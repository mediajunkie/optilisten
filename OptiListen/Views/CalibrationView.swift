import SwiftUI

/// Teaches the app the difference between your voice and everything else.
///
/// This is the direct descendant of the 2022 thread where Christian sent Fractal
/// an .aif recording "to help train the thresholds." Same problem, but solved
/// with the user in the room instead of a developer guessing offline — and,
/// crucially, it can *fail honestly*: if the two readings are too close together,
/// the app says the room won't work rather than shipping a confident wrong ratio.
struct CalibrationView: View {
    enum Phase: Equatable { case intro, speaking, quiet, result, tooClose, failed(String) }

    @Environment(\.dismiss) private var dismiss
    let source: LiveMicSource

    @State private var phase: Phase = .intro
    @State private var userLevel: Double = 0
    @State private var ambientLevel: Double = 0

    private let sampleSeconds: TimeInterval = 6

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Spacer()
                content
                Spacer()
                action
            }
            .padding(32)
            .multilineTextAlignment(.center)
            .navigationTitle("Calibrate")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { dismiss() }
                }
            }
        }
    }

    @ViewBuilder private var content: some View {
        switch phase {
        case .intro:
            Image(systemName: "waveform")
                .font(.system(size: 44, weight: .light))
                .foregroundStyle(.secondary)
            Text("Put the phone where you'll keep it during calls — face up, beside you, about an arm's length.")
            Text("Two quick readings: one with you talking, one with you quiet. Nothing is recorded.")
                .font(.footnote)
                .foregroundStyle(.secondary)

        case .speaking:
            Image(systemName: "mic.fill")
                .font(.system(size: 44))
                .foregroundStyle(.orange)
                .symbolEffect(.pulse)
            Text("Talk normally.")
                .font(.title2)
            Text("Anything at all — read this sentence out loud twice.")
                .font(.footnote)
                .foregroundStyle(.secondary)

        case .quiet:
            Image(systemName: "speaker.wave.2")
                .font(.system(size: 44, weight: .light))
                .foregroundStyle(.blue)
            Text("Now stay quiet.")
                .font(.title2)
            Text("Leave the room as it'll be during a call — laptop audio on if that's how you work.")
                .font(.footnote)
                .foregroundStyle(.secondary)

        case .result:
            Image(systemName: "checkmark.circle")
                .font(.system(size: 44, weight: .light))
                .foregroundStyle(.green)
            Text("Ready.")
                .font(.title2)
            Text("Your voice reads about \(Int(userLevel - ambientLevel)) dB above the room, which is a clean enough gap to tell you apart from everyone else.")
                .font(.footnote)
                .foregroundStyle(.secondary)

        case .failed(let message):
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 44, weight: .light))
                .foregroundStyle(.red)
            Text("Calibration didn't run.")
                .font(.title2)
            Text(message)
                .font(.footnote)
                .foregroundStyle(.secondary)

        case .tooClose:
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 44, weight: .light))
                .foregroundStyle(.orange)
            Text("This room won't give a reliable reading.")
                .font(.title2)
            Text("Your voice and the background are too close together — usually headphones, a loud room, or the phone too far away. You can still practice; you just won't get a percentage, and that's a fine way to use this.")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
    }

    @ViewBuilder private var action: some View {
        switch phase {
        case .intro:
            Button("Begin") { run() }
                .buttonStyle(.borderedProminent)
        case .speaking, .quiet:
            ProgressView()
        case .result:
            Button("Done") { dismiss() }
                .buttonStyle(.borderedProminent)
        case .tooClose:
            VStack(spacing: 12) {
                Button("Try again") { phase = .intro }
                    .buttonStyle(.borderedProminent)
                Button("Practice without a number") { dismiss() }
            }
        case .failed:
            VStack(spacing: 12) {
                Button("Try again") { phase = .intro }
                    .buttonStyle(.borderedProminent)
                Button("Copy diagnostics") {
                    UIPasteboard.general.string = source.eventLogText
                }
                .font(.footnote)
            }
        }
    }

    /// Run the two readings.
    ///
    /// This was `(try? await source.sampleLevel(...)) ?? -20` and `?? -50`.
    /// Those two fallbacks are numerically `Calibration.unavailable`, whose
    /// 30 dB gap passes `isUsable` — so a calibration in which *both readings
    /// failed* rendered a green checkmark and "Ready." A failure that reports
    /// itself as success is the defect class this build exists to remove, and
    /// this was its worst instance.
    private func run() {
        Task {
            do {
                phase = .speaking
                userLevel = try await source.sampleLevel(for: sampleSeconds)

                phase = .quiet
                ambientLevel = try await source.sampleLevel(for: sampleSeconds)

                let calibration = source.applyCalibration(
                    userLevel: userLevel,
                    ambientLevel: ambientLevel
                )
                phase = calibration.isUsable ? .result : .tooClose
            } catch {
                let message = (error as? LocalizedError)?.errorDescription
                    ?? error.localizedDescription
                phase = .failed(message)
            }
        }
    }
}
