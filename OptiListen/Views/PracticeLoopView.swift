import SwiftUI
import SwiftData
import UIKit

/// The loop: intention → conversation → reflection.
///
/// One screen per step, no skipping forward, and the reflection step cannot be
/// dismissed into nothing — it can be *deferred*, which is different, because a
/// deferred reflection comes back and an abandoned one doesn't.
struct PracticeLoopView: View {
    enum Step { case intention, listening, reflection }

    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    let source: LiveMicSource

    @State private var step: Step = .intention
#if DEBUG
    @State private var practice = ScreenshotFixture.prefilledPractice()
#else
    @State private var practice = Practice()
#endif
    @State private var usingHeadphones = false

    var body: some View {
        NavigationStack {
            Group {
                switch step {
                case .intention:
                    IntentionStep(practice: $practice, usingHeadphones: $usingHeadphones) {
                        practice.intentionSetAt = .now
                        step = .listening
                    }
                case .listening:
                    ListeningStep(
                        practice: $practice,
                        source: source,
                        usingHeadphones: usingHeadphones
                    ) {
                        captureEvidence()
                        step = .reflection
                    }
                case .reflection:
                    ReflectionStep(practice: $practice) {
                        practice.reflectedAt = .now
                        context.insert(practice)
                        // The loop closing is the product's whole payoff and it
                        // used to feel like cancelling a form. One soft
                        // acknowledgement, through touch, then the count moves
                        // on Home where he can watch it.
                        UINotificationFeedbackGenerator().notificationOccurred(.success)
                        dismiss()
                    } onDefer: {
                        context.insert(practice) // saved, unreflected, will resurface
                        dismiss()
                    }
                }
            }
            .animation(.snappy, value: step)
        }
        .interactiveDismissDisabled(step == .reflection)
#if DEBUG
        .onAppear {
            // Jump to the requested step the same way the buttons would have.
            switch ScreenshotFixture.initialStep {
            case "listening":
                practice.intentionSetAt = .now
                step = .listening
            case "reflection":
                practice.intentionSetAt = .now
                captureEvidence()
                step = .reflection
            default:
                break
            }
        }
#endif
    }

    private func captureEvidence() {
        Task {
            await source.stop()
            // Headphones mean the microphone only ever heard the user, so the
            // ratio is meaningless. Record the duration, refuse the number.
            guard !usingHeadphones, source.calibration.isUsable,
                  source.state.failureText == nil, source.buffersReceived > 0 else { return }
            practice.measuredSpeakingShare = source.currentShare
            practice.evidenceDuration = source.observedDuration
            practice.evidenceSourceID = source.id
            practice.userSpeakingSeconds = source.userSpeakingSeconds
            practice.otherSpeakingSeconds = source.otherSpeakingSeconds
            practice.silenceSeconds = source.silenceSeconds
        }
    }
}

// MARK: - 1. Intention

private struct IntentionStep: View {
    @Binding var practice: Practice
    @Binding var usingHeadphones: Bool
    var onStart: () -> Void

    var body: some View {
        Form {
            Section {
                TextField("What's this conversation?", text: $practice.label)
                    .textInputAutocapitalization(.sentences)
            } header: {
                Text("Optional")
            }

            Section {
                VStack(alignment: .leading, spacing: 12) {
                    Text(practice.goalPercentText)
                        .font(.system(size: 44, weight: .light, design: .rounded))
                        .monospacedDigit()
                        .contentTransition(.numericText())
                    Slider(value: $practice.goalSpeakingShare, in: 0.05...0.75, step: 0.05)
                    Text("Share of the conversation you intend to spend talking.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
                .padding(.vertical, 4)
            } header: {
                Text("Your ceiling")
            }

            Section {
                TextField("Ask before answering.", text: $practice.focus, axis: .vertical)
                    .lineLimit(2...4)
            } header: {
                Text("What are you practicing?")
            } footer: {
                Text("One line. This is the part you'll actually remember mid-conversation.")
            }

            Section {
                Toggle("I'm wearing headphones", isOn: $usingHeadphones)
            } footer: {
                Text(usingHeadphones
                     ? "Then the mic only hears you, so there's no ratio to read. You'll still set an intention and reflect — just without a number."
                     : "Set the phone face-up beside you, screen on. It listens to the room; nothing is recorded or sent anywhere.")
            }
        }
        .navigationTitle("Before")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Start", action: onStart)
                    .disabled(practice.focus.trimmingCharacters(in: .whitespaces).isEmpty)
            }
        }
    }
}

// MARK: - 2. Listening

private struct ListeningStep: View {
    @Binding var practice: Practice
    let source: LiveMicSource
    let usingHeadphones: Bool
    var onEnd: () -> Void

    @State private var elapsed: TimeInterval = 0
    @State private var showingDiagnostics = false
    /// What the screen shows, which is deliberately not what the microphone
    /// just heard. `currentShare` moves every 100 ms; a percentage twitching in
    /// peripheral vision is agitating in exactly the way this app must not be,
    /// and the user is supposed to be looking at a person. The reading is
    /// unchanged, only its presentation settles.
    @State private var shownShare: Double = 0
    @State private var hasCrossed = false
    private let tick = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    /// Computed from the settled value so the colour and the digits never
    /// disagree with each other for a second at a time.
    private var overGoal: Bool { shownShare > practice.goalSpeakingShare }

    var body: some View {
        VStack(spacing: 28) {
            Spacer()

            if let failure = source.state.failureText {
                // A failed start used to be pixel-identical to a working one.
                CaptureFailureCard(message: failure, log: source.eventLogText)
            } else if usingHeadphones || !source.calibration.isUsable {
                // No number, on purpose. The intention still does the work.
                VStack(spacing: 14) {
                    Image(systemName: "ear")
                        .font(.system(size: 40, weight: .light))
                        .foregroundStyle(.secondary)
                    Text(practice.focus)
                        .font(.title3)
                        .multilineTextAlignment(.center)
                    Text("No reading this time.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
                .padding(.horizontal, 32)
            } else {
                // The number is the share of speech that is YOU, measured against a
                // ceiling you set. Unlabelled, in an app called OptiListen, with the
                // practice line sitting directly underneath, a rising number reads as
                // success when it means the opposite: 2026-09-20 field note, verbatim,
                // "i was distracted by not understanding or trusting the readout."
                // So the number now says what it counts, and "of X%" is gone: it parsed
                // as a fraction of a fraction rather than a limit.
                VStack(spacing: 4) {
                    Text(Practice.percent(shownShare))
                        .font(Theme.numeral)
                        .monospacedDigit()
                        .contentTransition(.numericText())
                        .foregroundStyle(overGoal ? Theme.over : .primary)
                    Text("of the talking is you")
                        .font(.subheadline.weight(.medium))
                    Text(overGoal
                         ? "over your \(practice.goalPercentText) ceiling"
                         : "ceiling \(practice.goalPercentText)")
                        .font(.footnote)
                        .foregroundStyle(overGoal ? Theme.over : .secondary)
                }

                VStack(spacing: 2) {
                    Text("practising")
                        .font(.caption)
                        .textCase(.uppercase)
                        .foregroundStyle(.tertiary)
                    Text(practice.focus)
                        .font(.title3)
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal, 32)
                .padding(.top, 18)

                // Two things that were previously invisible and both of which
                // render as a confident 0%: an engine that started and is
                // receiving nothing, and a number computed against the
                // placeholder calibration.
                if source.isRunning && source.buffersReceived == 0 && elapsed >= 3 {
                    Label("No audio is arriving from the microphone.", systemImage: "exclamationmark.triangle")
                        .font(.footnote)
                        .foregroundStyle(.orange)
                        .padding(.horizontal, 32)
                }
                if !source.isCalibrated {
                    Text("Not calibrated, so this number is against placeholder thresholds.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                        .padding(.horizontal, 32)
                }
                if source.calibration.isMarginal {
                    Text("Your voice and the room are close together. Treat the split between you and others as rough.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                        .padding(.horizontal, 32)
                }
                if source.silenceSeconds == 0 && source.observedDuration > 30 {
                    Label("Nothing has been quiet yet, so everything is counting as speech.", systemImage: "exclamationmark.triangle")
                        .font(.footnote)
                        .foregroundStyle(.orange)
                        .padding(.horizontal, 32)
                }
            }

            Spacer()

            Text(Duration.seconds(elapsed).formatted(.time(pattern: .minuteSecond)))
                .font(.footnote.monospacedDigit())
                .foregroundStyle(.tertiary)

            // Was a filled destructive red: the loudest element on a screen
            // whose subject is listening quietly. Ending a practice is not a
            // destructive act, it is the middle of the loop.
            Button(action: onEnd) {
                Text("End")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 6)
            }
            .buttonStyle(.bordered)
            .padding(.horizontal, 32)
            .padding(.bottom, 24)
        }
        .navigationTitle(practice.label.isEmpty ? "Listening" : practice.label)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showingDiagnostics = true
                } label: {
                    Image(systemName: "stethoscope")
                }
                .accessibilityLabel("Diagnostics")
            }
        }
        .sheet(isPresented: $showingDiagnostics) {
            DiagnosticsSheet(log: source.eventLogText)
        }
        .persistentSystemOverlays(.hidden)
        .onReceive(tick) { _ in
            elapsed += 1
            withAnimation(.easeInOut(duration: 0.6)) {
                shownShare = source.currentShare
            }
        }
        // The one thing worth interrupting for, delivered by touch rather than
        // by making him look at the phone. Once per session, on the crossing,
        // not on every buffer that wobbles over the line.
        .onChange(of: overGoal) { _, isOver in
            guard isOver, !hasCrossed else { return }
            hasCrossed = true
            UIImpactFeedbackGenerator(style: .soft).impactOccurred()
        }
        .task {
            guard !usingHeadphones else { return }
#if DEBUG
            // A scripted reading arrives mid-conversation; the clock should say so.
            if source.isScreenshotFixture {
                elapsed = source.observedDuration
                shownShare = source.currentShare
            }
#endif
            // The error is not discarded and it is not rethrown into nothing:
            // `start()` has already written the reason into `source.state`,
            // and `body` renders it. This was `try? await source.start()`,
            // which swallowed four distinct throw sites and left the screen
            // showing a calm 0%.
            do { try await source.start() } catch { }
        }
        // The screen stays lit because the phone is functioning as an
        // instrument on the desk, not a phone in a pocket. This is the
        // deliberate replacement for 1.x's losing fight with background mode.
        .onAppear { UIApplication.shared.isIdleTimerDisabled = true }
        .onDisappear { UIApplication.shared.isIdleTimerDisabled = false }
    }
}

// MARK: - 3. Reflection

private struct ReflectionStep: View {
    @Binding var practice: Practice
    var onDone: () -> Void
    var onDefer: () -> Void

    var body: some View {
        Form {
            if practice.hasEvidence, let measured = practice.measuredPercentText {
                Section {
                    HStack(alignment: .firstTextBaseline) {
                        VStack(alignment: .leading, spacing: 1) {
                            Text(measured)
                                .font(Theme.numeralSmall)
                                .monospacedDigit()
                            Text("of the talking was you")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        Text("ceiling \(practice.goalPercentText)")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    if let breakdown = practice.breakdownText {
                        Text(breakdown)
                            .font(.footnote.monospacedDigit())
                            .foregroundStyle(.secondary)
                    }
                    if practice.heardNoSilence {
                        Label(
                            "Nothing was ever quiet, so every moment was counted as someone speaking. In a noisy place, or outdoors, this reading is not meaningful.",
                            systemImage: "exclamationmark.triangle"
                        )
                        .font(.footnote)
                        .foregroundStyle(.orange)
                    }
                } footer: {
                    if practice.evidenceIsPartial {
                        Label(
                            "Heard \(Duration.seconds(practice.evidenceDuration).formatted(.time(pattern: .minuteSecond))) of the conversation, so treat this as a sample rather than a verdict.",
                            systemImage: "info.circle"
                        )
                    }
                }
            }

            Section {
                Picker("Presence", selection: Binding(
                    get: { practice.presence ?? 3 },
                    set: { practice.presence = $0 }
                )) {
                    ForEach(1...5, id: \.self) { Text("\($0)").tag($0) }
                }
                .pickerStyle(.segmented)
            } header: {
                Text("How present were you?")
            } footer: {
                Text("Your call, not the microphone's. You can hit your number and still have been somewhere else.")
            }

            Section {
                TextField("What happened?", text: $practice.note, axis: .vertical)
                    .lineLimit(3...8)
            } header: {
                Text("You were practicing: \(practice.focus)")
            }
        }
        .navigationTitle("After")
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Done", action: onDone)
                    .disabled(practice.presence == nil)
            }
            ToolbarItem(placement: .cancellationAction) {
                Button("Later", action: onDefer)
            }
        }
        .onAppear { if practice.presence == nil { practice.presence = 3 } }
    }
}

// MARK: - Diagnostics surfaces

/// Why there is no reading, said on the screen the user is already looking at.
///
/// Deliberately not an alert and not a crash sheet: a TestFlight crash
/// submission only exists if the tester happens to tap Share on a modal, which
/// is how 2.0 (3) produced a failure nobody could examine. This renders where
/// the number renders, and the log copies with one tap.
private struct CaptureFailureCard: View {
    let message: String
    let log: String

    @State private var copied = false

    var body: some View {
        VStack(spacing: 14) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 40, weight: .light))
                .foregroundStyle(.orange)
            Text("Listening didn't start.")
                .font(.title3)
            Text(message)
                .font(.footnote)
                .foregroundStyle(.secondary)
            Button(copied ? "Copied" : "Copy diagnostics") {
                UIPasteboard.general.string = log
                copied = true
            }
            .font(.footnote)
            .buttonStyle(.bordered)
        }
        .multilineTextAlignment(.center)
        .padding(.horizontal, 32)
    }
}

/// The whole capture log, in order, copyable.
private struct DiagnosticsSheet: View {
    let log: String

    @Environment(\.dismiss) private var dismiss
    @State private var copied = false

    var body: some View {
        NavigationStack {
            ScrollView {
                Text(log)
                    .font(.caption.monospaced())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .textSelection(.enabled)
                    .padding()
            }
            .navigationTitle("Diagnostics")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(copied ? "Copied" : "Copy") {
                        UIPasteboard.general.string = log
                        copied = true
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
}
