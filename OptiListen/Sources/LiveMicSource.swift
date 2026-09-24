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
///
/// ## 2026-09-16: the same rule, turned on this file
///
/// Three builds were diagnosed by reading source, because the app had no way to
/// say what had happened to it. Every defect this month presented identically:
/// it died, or it did nothing, and it told no one why. `start()` had four throw
/// sites and its only caller discarded all four with `try?`; calibration
/// substituted `-20` and `-50` for two failed readings and rendered the result
/// as success. **A failed capture was pixel-identical to a working one in a
/// quiet room.**
///
/// So this type now reports. `state` is what the capture path believes about
/// itself, `events` is what it did in order, and both are rendered rather than
/// inferred. Nothing here fixes a crash; it converts the next bug from an
/// inference problem into a reading problem.
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
        ///
        /// This used to be `ambientLevel - 6.0`, which is backwards. `ambientLevel`
        /// is measured with the user deliberately quiet, so by construction a moment
        /// *at* ambient is nobody talking. Putting the floor 6 dB below it meant the
        /// room's own noise could never be silence, and the "other speaking" bucket
        /// absorbed the entire noise floor instead.
        ///
        /// 2026-09-20, outdoors: 100.8 seconds of capture produced `silence 0.0`.
        /// Not a rounding artifact — the floor was unreachable, so every buffer was
        /// scored as speech and the percentage was computed over continuous noise.
        var silenceFloor: Double { ambientLevel + 3.0 }

        /// Calibration is meaningless if the two readings are too close:
        /// headphones, a loud room, a phone across the desk.
        ///
        /// The bar was 8 dB, which is enough to separate two buckets and not enough
        /// for three. With the floor at ambient+3 and the threshold at 45% of the
        /// gap, "other speaking" only exists above a gap of about 6.7 dB, and it is
        /// a usable width only well past that. The 2026-09-20 field run passed at
        /// 9.7 dB and produced a number the tester correctly did not believe.
        ///
        /// 12 and 16 are first estimates from that single run, not measurements.
        /// The next field test is what validates or moves them, and the numbers are
        /// in the diagnostics log so the next run can argue with them.
        var isUsable: Bool { userLevel - ambientLevel >= 12.0 }

        /// Separated, but not by much. The reading is shown and marked rather than
        /// withheld, because refusing a number the user can sanity-check themselves
        /// is its own kind of dishonesty.
        var isMarginal: Bool {
            let gap = userLevel - ambientLevel
            return gap >= 12.0 && gap < 16.0
        }

        /// The value held before anyone has calibrated.
        ///
        /// **Known defect, deliberately not changed in this build.** Its 30 dB
        /// gap passes `isUsable`, so "never calibrated" is numerically
        /// indistinguishable from "calibrated well" — the same
        /// failure-looks-like-success shape this build exists to remove.
        /// Making `calibration` an `Optional` and deleting this is the right
        /// repair, and it changes classification behaviour, so it does not
        /// belong in a build whose job is to observe. `isCalibrated` below
        /// makes the distinction *visible* in the meantime, which is what a
        /// diagnostic build owes you.
        static let unavailable = Calibration(userLevel: -20, ambientLevel: -50)
    }

    private(set) var calibration: Calibration = .unavailable

    /// Whether `calibration` came from two real readings or is still the
    /// placeholder. Read by the UI; see the note on `.unavailable`.
    private(set) var isCalibrated = false

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
        isCalibrated = true
        note(String(
            format: "calibrated — user %.1f dBFS, ambient %.1f dBFS, gap %.1f dB, threshold %.1f",
            userLevel, ambientLevel, userLevel - ambientLevel, calibration.threshold
        ) + ", usable \(calibration.isUsable ? "yes" : "NO")")
        return calibration
    }

    // MARK: Diagnostics

    /// What the capture path believes about itself, right now.
    ///
    /// The point of the associated `String` on `.failed` is that the reason
    /// survives to the screen. Every path that can fail sets this before it
    /// throws, so even a caller that discards the error renders the truth.
    enum CaptureState: Equatable, Sendable {
        case idle
        case starting
        case running
        case failed(String)

        var label: String {
            switch self {
            case .idle: "idle"
            case .starting: "starting"
            case .running: "running"
            case .failed(let reason): "failed(\(reason))"
            }
        }

        var failureText: String? {
            if case .failed(let reason) = self { return reason }
            return nil
        }
    }

    private(set) var state: CaptureState = .idle

    /// One line of what the capture path did, in order.
    struct CaptureEvent: Identifiable, Sendable {
        let id = UUID()
        let at = Date()
        let text: String
    }

    private(set) var events: [CaptureEvent] = []
    private let eventCeiling = 300

    /// Buffers actually delivered by the tap.
    ///
    /// This is the number that separates the two failures we could not tell
    /// apart: `isRunning == true` with `buffersReceived == 0` means the engine
    /// started and the microphone is sending nothing, which reads on screen as
    /// a calm `0%` and is the "it failed to start tracking anything" xian
    /// reported against 2.0 (3).
    private(set) var buffersReceived = 0
    private(set) var lastLevel: Double?

    /// Record one line. Cheap, ordered, and capped — this runs per session, not
    /// per buffer.
    func note(_ text: String) {
        events.append(CaptureEvent(text: text))
        if events.count > eventCeiling {
            events.removeFirst(events.count - eventCeiling)
        }
    }

    /// The log as text the tester can paste into a message.
    ///
    /// Deliberately not a crash report: it exists so that learning what
    /// happened does not depend on catching a modal sheet and tapping Share.
    var eventLogText: String {
        let header = [
            "OptiListen capture log",
            "state: \(state.label)",
            "running: \(isRunning)  buffers: \(buffersReceived)",
            "calibrated: \(isCalibrated)  usable: \(calibration.isUsable)",
            String(format: "user %.1f / ambient %.1f / threshold %.1f / floor %.1f",
                   calibration.userLevel, calibration.ambientLevel,
                   calibration.threshold, calibration.silenceFloor),
            String(format: "heard %.1fs — user %.1f / other %.1f / silence %.1f",
                   observedDuration, userSpeakingSeconds,
                   otherSpeakingSeconds, silenceSeconds),
            ""
        ].joined(separator: "\n")

        let lines = events.map {
            "\($0.at.formatted(date: .omitted, time: .standard))  \($0.text)"
        }
        return header + lines.joined(separator: "\n")
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

#if DEBUG
    // MARK: Screenshot fixture (Debug builds only)

    // The Simulator has no microphone, so the listening and reflection screens can
    // never show a number there — and those are the screens the App Store art
    // exists to show. `ScreenshotFixture.source()` builds one of these when the app
    // is launched with `-screenshot-fixture <share>`: calibration set to a usable
    // gap, the three buckets pre-filled so `currentShare` is the requested share
    // and `observedDuration` the requested elapsed time, and a one-second clock
    // that keeps the split moving so the screen reads as live. The audio session
    // is never touched. It lives in this file because the counters are
    // `private(set)`; nothing in this block compiles into a Release build.
    private var fixtureShare: Double?
    private var fixtureClock: Task<Void, Never>?

    var isScreenshotFixture: Bool { fixtureShare != nil }

    static func screenshotFixture(share: Double, elapsed: TimeInterval) -> LiveMicSource {
        let source = LiveMicSource()
        source.fixtureShare = share
        source.applyCalibration(userLevel: -18, ambientLevel: -46)
        let speech = elapsed * 0.85
        source.userSpeakingSeconds = speech * share
        source.otherSpeakingSeconds = speech * (1 - share)
        source.silenceSeconds = elapsed - speech
        source.buffersReceived = Int(elapsed / source.bufferSeconds)
        source.note("SCREENSHOT FIXTURE — scripted reading; the microphone is not in use")
        return source
    }

    private func fixtureStart() {
        guard let share = fixtureShare, !isRunning else { return }
        isRunning = true
        state = .running
        fixtureClock = Task { [weak self] in
            while !Task.isCancelled {
                try? await Task.sleep(for: .seconds(1))
                guard let self, !Task.isCancelled else { return }
                self.userSpeakingSeconds += 0.85 * share
                self.otherSpeakingSeconds += 0.85 * (1 - share)
                self.silenceSeconds += 0.15
                self.buffersReceived += 10
            }
        }
    }

    private func fixtureStop() {
        fixtureClock?.cancel()
        fixtureClock = nil
        isRunning = false
        state = .idle
    }
#endif

    // MARK: Engine

    private let engine = AVAudioEngine()
    private let bufferSeconds: TimeInterval = 0.1

    /// Held so the observer can be removed. It was previously discarded, which
    /// added a fresh observer on every `start()` and never removed any.
    private var interruptionObserver: NSObjectProtocol?

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
#if DEBUG
        if isScreenshotFixture { fixtureStart(); return }
#endif
        guard !isRunning else {
            note("start() ignored — already running")
            return
        }

        state = .starting
        note("start() requested")

        do {
            guard await isAvailable() else { throw TalkRatioSourceError.permissionDenied }
            note("microphone permission: granted")

            reset()
            try configureSession()
            note("session configured — .record / .measurement / allowBluetooth, active")

            observeInterruptions()

            let input = engine.inputNode
            let format = input.outputFormat(forBus: 0)
            note("input format — \(Int(format.sampleRate)) Hz, \(format.channelCount) ch")
            guard format.sampleRate > 0 else { throw TalkRatioSourceError.inputUnavailable }
            let frames = AVAudioFrameCount(format.sampleRate * bufferSeconds)

            // This block runs on AVFAudio's real-time messenger thread, and it must not
            // inherit this class's `@MainActor` isolation. A non-`@Sendable` closure
            // written inside an isolated context inherits that isolation, and under Swift 6
            // with `SWIFT_STRICT_CONCURRENCY: complete` the compiler emits a hard
            // `_swift_task_checkIsolated` precondition at closure entry. Off the main
            // actor that precondition is a `SIGTRAP`, not a warning: it is what killed
            // 2.0 (2) at `closure #1 in LiveMicSource.start()`, one frame below
            // `AVAudioNodeTap::CheckEmitBuffer`.
            //
            // `@Sendable` makes the closure nonisolated. It then touches no isolated
            // state at all: the level is computed by a `nonisolated static`, and the only
            // thing that crosses to the actor is a `Double`. `sampleLevel`'s tap was
            // always shaped this way — it captures no `self` — which is precisely why
            // calibration never crashed while this site always would. The two tap sites
            // now agree on the one property that matters.
            input.installTap(onBus: 0, bufferSize: frames, format: format) { @Sendable [weak self] buffer, _ in
                let level = Self.rmsDecibels(buffer)
                Task { @MainActor in self?.classify(level) }
            }
            note("tap installed — \(frames) frames per buffer")

            engine.prepare()
            try engine.start()

            isRunning = true
            state = .running
            note(isCalibrated
                 ? "engine running — calibrated"
                 : "engine running — NOT CALIBRATED, classifying against placeholder thresholds")
        } catch {
            await fail(error, during: "start()")
            throw error
        }
    }

    func stop() async {
#if DEBUG
        if isScreenshotFixture { fixtureStop(); return }
#endif
        note("stop() requested — state was \(state.label)")
        await teardown()
        // A failure outlives the stop that follows it: the reflection screen
        // still has to be able to say why there is no number.
        if state.failureText == nil { state = .idle }
    }

    func reset() {
        userSpeakingSeconds = 0
        otherSpeakingSeconds = 0
        silenceSeconds = 0
        wasInterrupted = false
        buffersReceived = 0
        lastLevel = nil
    }

    /// Record a failure where the UI can read it, then tear down.
    ///
    /// The old `start()` left `isRunning == false` on every throw, and `stop()`
    /// guarded on `isRunning` — so after a failed start the engine could never
    /// be torn down, and a second attempt installed a second tap on a bus that
    /// already had one.
    private func fail(_ error: Error, during phase: String) async {
        let reason = (error as? LocalizedError)?.errorDescription ?? error.localizedDescription
        state = .failed(reason)
        note("\(phase) FAILED — \(reason)  [\(String(describing: error))]")
        await teardown()
    }

    /// Return the engine to a known state from *any* state, including a
    /// half-built one. Every step is individually safe to repeat.
    private func teardown() async {
        engine.inputNode.removeTap(onBus: 0)
        if engine.isRunning { engine.stop() }
        isRunning = false

        if let token = interruptionObserver {
            NotificationCenter.default.removeObserver(token)
            interruptionObserver = nil
        }

        do {
            try AVAudioSession.sharedInstance()
                .setActive(false, options: .notifyOthersOnDeactivation)
        } catch {
            note("session deactivate failed — \(error.localizedDescription)")
        }
    }

    // MARK: Classification

    private func classify(_ level: Double) {
        buffersReceived += 1
        lastLevel = level

        if buffersReceived == 1 {
            note(String(format: "first buffer — %.1f dBFS", level))
        }

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
        note("sampleLevel(\(Int(duration))s) requested")
        do {
            // 2026-09-14: calibration runs BEFORE any start(), so on a first run this was
            // the first code to touch the microphone — with permission still `undetermined`.
            // The engine then has no live input, outputFormat(forBus:) returns 0 Hz, and
            // installTap raises `required condition is false: format.sampleRate > 0`, an
            // uncatchable ObjC exception. Every dev device had permission from an earlier
            // run, so only a fresh install (i.e. every TestFlight install) could hit it.
            // Same gate start() already has: requests permission when undetermined.
            guard await isAvailable() else { throw TalkRatioSourceError.permissionDenied }

            try configureSession()

            let input = engine.inputNode
            let format = input.outputFormat(forBus: 0)
            note("sample input format — \(Int(format.sampleRate)) Hz")
            // Defensive, and the durable half of the fix: a tap that cannot see its input
            // must fail as a report, not a crash. Covers any future variant of this.
            guard format.sampleRate > 0 else { throw TalkRatioSourceError.inputUnavailable }
            let frames = AVAudioFrameCount(format.sampleRate * bufferSeconds)

            let samples = Samples()
            input.installTap(onBus: 0, bufferSize: frames, format: format) { @Sendable buffer, _ in
                // 2026-09-16 (Pard, compile fix only): compute the level BEFORE the Task, exactly
                // as the start() tap above already does. `@Sendable` made the compiler strict about
                // the previous form — `AVAudioPCMBuffer` is not Sendable, so capturing it inside
                // the Task is "passing closure as a 'sending' parameter" and fails to build. A
                // Double crosses cleanly. Cairn's shape, mirrored; no behaviour change intended.
                let level = Self.rmsDecibels(buffer)
                Task { await samples.append(level) }
            }

            engine.prepare()
            try engine.start()
            try? await Task.sleep(for: .seconds(duration))

            input.removeTap(onBus: 0)
            engine.stop()

            let count = await samples.count
            let mean = await samples.mean
            note("sample complete — \(count) buffers, mean " + String(format: "%.1f", mean) + " dBFS")
            // A reading taken from nothing is not a reading. Previously this
            // returned the -80 floor, which looks exactly like a silent room.
            guard count > 0 else { throw TalkRatioSourceError.inputUnavailable }
            return mean
        } catch {
            await fail(error, during: "sampleLevel()")
            throw error
        }
    }

    private actor Samples {
        private var values: [Double] = []
        func append(_ value: Double) { values.append(value) }
        var count: Int { values.count }
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
        if let token = interruptionObserver {
            NotificationCenter.default.removeObserver(token)
            interruptionObserver = nil
        }
        interruptionObserver = NotificationCenter.default.addObserver(
            forName: AVAudioSession.interruptionNotification,
            object: AVAudioSession.sharedInstance(),
            queue: .main
        ) { @Sendable [weak self] _ in
            Task { @MainActor in
                self?.wasInterrupted = true
                self?.note("interrupted by the system — stopping")
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
