import SwiftUI
import SwiftData

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
    @State private var practice = Practice()
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
    }

    private func captureEvidence() {
        Task {
            await source.stop()
            // Headphones mean the microphone only ever heard the user, so the
            // ratio is meaningless. Record the duration, refuse the number.
            guard !usingHeadphones, source.calibration.isUsable else { return }
            practice.measuredSpeakingShare = source.currentShare
            practice.evidenceDuration = source.observedDuration
            practice.evidenceSourceID = source.id
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
    private let tick = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    private var overGoal: Bool { source.currentShare > practice.goalSpeakingShare }

    var body: some View {
        VStack(spacing: 28) {
            Spacer()

            if usingHeadphones || !source.calibration.isUsable {
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
                VStack(spacing: 6) {
                    Text(Practice.percent(source.currentShare))
                        .font(.system(size: 72, weight: .thin, design: .rounded))
                        .monospacedDigit()
                        .contentTransition(.numericText())
                        .foregroundStyle(overGoal ? .orange : .primary)
                    Text("of \(practice.goalPercentText)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                Text(practice.focus)
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
            }

            Spacer()

            Text(Duration.seconds(elapsed).formatted(.time(pattern: .minuteSecond)))
                .font(.footnote.monospacedDigit())
                .foregroundStyle(.tertiary)

            Button(role: .destructive, action: onEnd) {
                Text("End")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 6)
            }
            .buttonStyle(.borderedProminent)
            .padding(.horizontal, 32)
            .padding(.bottom, 24)
        }
        .navigationTitle(practice.label.isEmpty ? "Listening" : practice.label)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .persistentSystemOverlays(.hidden)
        .onReceive(tick) { _ in elapsed += 1 }
        .task {
            guard !usingHeadphones else { return }
            try? await source.start()
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
                    HStack {
                        Text(measured)
                            .font(.system(size: 34, weight: .light, design: .rounded))
                            .monospacedDigit()
                        Spacer()
                        Text("aimed at \(practice.goalPercentText)")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
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
