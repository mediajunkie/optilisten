import Foundation
import AVFoundation
import Observation

/// On-device evidence: the phone sits beside you and listens to the room.
///
/// ## What this actually measures
///
/// Not speech content — OptiListen never transcribes and never leaves the
/// device. It measures *loudness over time* and sorts each moment into three
/// buckets: you speaking, someone else speaking, silence.
///
/// The discriminator is proximity. Your voice, a foot from the phone, arrives
/// far louder than the other party's voice coming out of a laptop speaker
/// across the desk. That gap is what `Calibration` captures, and it is why
/// setup asks you to speak once and then stay quiet once.
///
/// ## What it cannot do, stated plainly
///
/// - **It needs the foreground.** iOS suspends audio capture for a backgrounded
///   app that isn't playing audio. OptiListen 1.x fought this and lost twice:
///   it shipped with a 30-second ceiling, later 50, and Apple rejected a build
///   over the background-mode workarounds in July 2023. 2.0 does not fight it.
///   The phone is a practice instrument you set beside you with the screen on,
///   the way you'd set down a metronome.
/// - **It degrades with headphones.** If the other party is in your ears, the
///   microphone hears only you, and every reading trends toward 100%. The UI
///   must ask about headphones and mark those sessions as user-only.
/// - **It cannot separate two people in the same room.** Anyone close to the
///   phone reads as you.
///
/// Every one of these is surfaced in the UI rather than hidden, because a
/// confident wrong number is worse than an honest partial one. That is the
/// lesson of 1.x encoded as a design rule.
@Observable
@MainActor
final class LiveMicSource: LiveTalkRatioSource {

    nonisolated let id = "live-mic"
    nonisolated let displayName = "This device"

    // MARK: Calibration

    struct Calibration: Codable, Sendable {
        /// Mean RMS, in dBFS, while the user speaks at conversational volume.
        var userLevel: Double
        /// Mean RMS, in dBFS, of the room with the user quiet — laptop speaker,
        /// fans, street noise.
        var ambientLevel: Double

        /// Midpoint between the two, the line that sorts a moment into
        /// "user" or "other". Biased slightly toward ambient so that a quiet
        /// remark still counts as the user speaking; under-counting your own
        /// talking is the failure mode that flatters the user, and flattering
        /// the user defeats the entire purpose of the app.
        var threshold: Double {
            ambientLevel + (userLevel - ambientLevel) * 0.45
        }

        /// Floor below which a moment is silence rather than anyone speaking.
        var silenceFloor: Double { ambientLevel - 6.0 }

        /// Calibration is meaningless if the two readings are too close —
        /// headphones, a very loud room, a phone across the desk.
        var isUsable: Bool { userLevel - ambientLevel >= 8.0 }

        static let unavailable = Calibration(userLevel: -20, ambientLevel: -50)
    }

    private(set) var calibration: Calibration = .unavailable

    /// Store a calibration built from two measured levels.
    ///
    /// The source owns this value deliberately — `private(set)` keeps the
    /// thresholds from being assembled in three places and drifting apart.
    /// Callers run the two samples, hand over the raw readings, and get the
    /// derived calibration back; construction lives here, once.
    @discardableResult
    func applyCalibration(userLevel: Double, ambientLevel: Double) -> Calibration {
        let calibration = Calibration(userLevel: userLevel, ambientLevel: ambientLevel)
        self.calibration = calibration
        return calibration
    }

    // MARK: Live state

    private(set) var isRunning = false
    private(set) var userSpeakingSeconds: TimeInterval = 0
    private(set) var otherSpeakingSeconds: TimeInterval = 0
    private(set) var silenceSeconds: TimeInterval = 0

    /// Set when the OS interrupts capture — a phone call, Siri, the app
    /// leaving the foreground. Evidence gathered after an interruption is
    /// still valid; it just covers less, and `observedDuration` says so.
    private(set) var wasInterrupted = false

    /// Share of *speaking* time that was the user. Silence is excluded
    /// deliberately: a conversation with long pauses shouldn't read as
    /// listening well. The practice is about the split between voices.
    var currentShare: Double {
        let speech = userSpeakingSeconds + otherSpeakingSeconds
        guard speech > 0 else { return 0 }
        return userSpeakingSeconds / speech
    }

    var observedDuration: TimeInterval {
        userSpeakingSeconds + otherSpeakingSeconds + silenceSeconds
    }

    // MARK: Engine

    private let engine = AVAudioEngine()
    private let bufferSeconds: TimeInterval = 0.1

    func isAvailable() async -> Bool {
        await withCheckedContinuation { continuation in
            switch AVAudioApplication.shared.recordPermission {
            case .granted:
                continuation.resume(returning: true)
            case .denied:
                continuation.resume(returning: false)
            case .undetermined:
                AVAudioApplication.requestRecordPermission { continuation.resume(returning: $0) }
            @unknown default:
                continuation.resume(returning: false)
            }
        }
    }

    func start() async throws {
        guard await isAvailable() else { throw TalkRatioSourceError.permissionDenied }
        guard !isRunning else { return }

        reset()
        try configureSession()
        observeInterruptions()

        let input = engine.inputNode
        let format = input.outputFormat(forBus: 0)
        let frames = AVAudioFrameCount(format.sampleRate * bufferSeconds)

        input.installTap(onBus: 0, bufferSize: frames, format: format) { [weak self] buffer, _ in
            guard let self else { return }
            let level = Self.rmsDecibels(buffer)
            Task { @MainActor in self.classify(level) }
        }

        engine.prepare()
        try engine.start()
        isRunning = true
    }

    func stop() async {
        guard isRunning else { return }
        engine.inputNode.removeTap(onBus: 0)
        engine.stop()
        isRunning = false
        try? AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
    }

    func reset() {
        userSpeakingSeconds = 0
        otherSpeakingSeconds = 0
        silenceSeconds = 0
        wasInterrupted = false
    }

    // MARK: Classification

    private func classify(_ level: Double) {
        guard calibration.isUsable else {
            silenceSeconds += bufferSeconds
            return
        }
        if level < calibration.silenceFloor {
            silenceSeconds += bufferSeconds
        } else if level >= calibration.threshold {
            userSpeakingSeconds += bufferSeconds
        } else {
            otherSpeakingSeconds += bufferSeconds
        }
    }

    // MARK: Calibration capture

    /// Sample the room for `duration`, returning mean dBFS. Called twice at
    /// setup: once while the user speaks, once while they're quiet.
    func sampleLevel(for duration: TimeInterval) async throws -> Double {
        try configureSession()

        let input = engine.inputNode
        let format = input.outputFormat(forBus: 0)
        let frames = AVAudioFrameCount(format.sampleRate * bufferSeconds)

        let samples = Samples()
        input.installTap(onBus: 0, bufferSize: frames, format: format) { buffer, _ in
            Task { await samples.append(Self.rmsDecibels(buffer)) }
        }

        engine.prepare()
        try engine.start()
        try? await Task.sleep(for: .seconds(duration))

        input.removeTap(onBus: 0)
        engine.stop()

        return await samples.mean
    }

    private actor Samples {
        private var values: [Double] = []
        func append(_ value: Double) { values.append(value) }
        var mean: Double {
            guard !values.isEmpty else { return -80 }
            return values.reduce(0, +) / Double(values.count)
        }
    }

    // MARK: Session plumbing

    private func configureSession() throws {
        let session = AVAudioSession.sharedInstance()
        // `.measurement` disables the processing that would otherwise
        // normalize away exactly the loudness differences we depend on.
        try session.setCategory(.record, mode: .measurement, options: [.allowBluetooth])
        try session.setActive(true)
    }

    private func observeInterruptions() {
        NotificationCenter.default.addObserver(
            forName: AVAudioSession.interruptionNotification,
            object: AVAudioSession.sharedInstance(),
            queue: .main
        ) { [weak self] _ in
            Task { @MainActor in
                self?.wasInterrupted = true
                await self?.stop()
            }
        }
    }

    // MARK: Signal

    nonisolated private static func rmsDecibels(_ buffer: AVAudioPCMBuffer) -> Double {
        guard let channel = buffer.floatChannelData?[0] else { return -80 }
        let count = Int(buffer.frameLength)
        guard count > 0 else { return -80 }

        var sum: Float = 0
        for i in 0..<count { sum += channel[i] * channel[i] }
        let rms = (sum / Float(count)).squareRoot()

        return rms > 0 ? max(20 * log10(Double(rms)), -80) : -80
    }
}
