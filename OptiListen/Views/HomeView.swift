import SwiftUI
import SwiftData
import Charts

/// Home.
///
/// The number at the top is **closed loops**, not average talk ratio. That is
/// the whole product argument in one design decision: Zoom, Teams, Granola and
/// Gong will all tell you your talk ratio, for free, at higher fidelity, without
/// you starting anything. None of them can tell you whether you set an intention
/// and came back to see how it went. So OptiListen counts the thing only it can
/// count, and treats the ratio as supporting evidence.
struct HomeView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Practice.createdAt, order: .reverse) private var practices: [Practice]

#if DEBUG
    @State private var source = ScreenshotFixture.source()
#else
    @State private var source = LiveMicSource()
#endif
    @State private var showingLoop = false
    @State private var showingCalibration = false

    private var closed: [Practice] { practices.filter(\.isComplete) }
    private var unreflected: [Practice] { practices.filter { $0.intentionSetAt != nil && $0.reflectedAt == nil } }
    private var withEvidence: [Practice] { closed.filter(\.hasEvidence) }

    var body: some View {
        NavigationStack {
            List {
                // No "0" in 52-point type on first launch. A zero is a poor
                // first handshake for an app whose opening screen should be
                // inviting one conversation, and the empty-state card below
                // already does that job.
                if !closed.isEmpty {
                Section {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("\(closed.count)")
                            .font(Theme.counter)
                            .monospacedDigit()
                            .contentTransition(.numericText())
                        Text(closed.count == 1 ? "conversation practiced" : "conversations practiced")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 8)
                    .listRowSeparator(.hidden)
                }
                // Closing the loop is the whole payoff of the product and it
                // used to happen off-screen. The count now moves where he can
                // see it move.
                .animation(.snappy, value: closed.count)
                }

                if !unreflected.isEmpty {
                    Section {
                        ForEach(unreflected) { practice in
                            NavigationLink {
                                // Resuming the reflection itself is still to build;
                                // until then this opens the record rather than a
                                // debug string, which is what shipped in 2.0 (4).
                                PracticeDetail(practice: practice)
                            } label: {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(practice.label.isEmpty ? "Untitled conversation" : practice.label)
                                    Text(practice.focus)
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                    } header: {
                        Text("Still open")
                    } footer: {
                        Text("A conversation you set an intention for but haven't looked back at. The looking back is the practice.")
                    }
                }

                if withEvidence.count >= 3 {
                    Section("Goal vs. actual") {
                        GoalChart(practices: withEvidence.reversed())
                            .frame(height: 180)
                            .listRowInsets(.init(top: 12, leading: 12, bottom: 12, trailing: 12))
                    }
                }

                if !closed.isEmpty {
                    Section("Recent") {
                        // 2026-09-20 field test: "There is no way to review past
                        // sessions. Touching a past session doesn't open it to show
                        // the notes as expected." The row already looked tappable.
                        ForEach(closed.prefix(12)) { practice in
                            NavigationLink {
                                PracticeDetail(practice: practice)
                            } label: {
                                PracticeRow(practice: practice)
                            }
                        }
                    }
                }

                if practices.isEmpty {
                    Section {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Set an intention before your next conversation.")
                                .font(.headline)
                            Text("Decide how much you mean to talk and what you're practicing. Have the conversation. Come back and say how it went. That loop is the whole thing, and the microphone is optional.")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.vertical, 8)
                    }
                }
            }
            .navigationTitle("OptiListen")
#if DEBUG
            .task {
                ScreenshotFixture.seedIfRequested(into: context, existing: practices.count)
                if ScreenshotFixture.initialStep != nil { showingLoop = true }
            }
#endif
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showingLoop = true
                    } label: {
                        Label("Begin", systemImage: "plus")
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button("Calibrate", systemImage: "slider.horizontal.3") {
                        showingCalibration = true
                    }
                    .labelStyle(.iconOnly)
                }
            }
            .sheet(isPresented: $showingLoop) {
                PracticeLoopView(source: source)
            }
            .sheet(isPresented: $showingCalibration) {
                CalibrationView(source: source)
            }
        }
    }
}

// MARK: - Row

private struct PracticeRow: View {
    let practice: Practice

    var body: some View {
        HStack(spacing: 14) {
            VStack(alignment: .leading, spacing: 3) {
                Text(practice.label.isEmpty ? "Untitled conversation" : practice.label)
                    .font(.body)
                Text(practice.focus)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 3) {
                if let measured = practice.measuredPercentText {
                    Text(measured)
                        .font(.body.monospacedDigit())
                        .foregroundStyle(practice.metGoal == true ? Theme.within : Theme.over)
                    Text("you talking")
                        .font(.caption2)
                        .foregroundStyle(.tertiary)
                } else {
                    Text("—")
                        .font(.body)
                        .foregroundStyle(.tertiary)
                }
                if let presence = practice.presence {
                    Text("presence \(presence)")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
            }
        }
    }
}

// MARK: - One past conversation

private struct PracticeDetail: View {
    let practice: Practice

    var body: some View {
        List {
            Section {
                if let measured = practice.measuredPercentText {
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
                            "Nothing was ever quiet, so every moment was counted as someone speaking. This reading is not meaningful.",
                            systemImage: "exclamationmark.triangle"
                        )
                        .font(.footnote)
                        .foregroundStyle(Theme.over)
                    }
                } else {
                    Text("No reading for this one. The loop still counts.")
                        .foregroundStyle(.secondary)
                }
            }

            Section("What you were practicing") {
                if practice.focus.isEmpty {
                    Text("Nothing written down.").foregroundStyle(.secondary)
                } else {
                    Text(practice.focus)
                }
            }

            if let presence = practice.presence {
                Section("How present you were") {
                    Text("\(presence) out of 5")
                }
            }

            Section("Notes") {
                if practice.note.isEmpty {
                    Text("No notes.").foregroundStyle(.secondary)
                } else {
                    Text(practice.note)
                }
            }

            Section {
                LabeledContent("Started", value: practice.createdAt.formatted(date: .abbreviated, time: .shortened))
                if let reflected = practice.reflectedAt {
                    LabeledContent("Reflected", value: reflected.formatted(date: .abbreviated, time: .shortened))
                }
            }
        }
        .navigationTitle(practice.label.isEmpty ? "Untitled conversation" : practice.label)
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Chart

private struct GoalChart: View {
    let practices: [Practice]

    var body: some View {
        Chart {
            ForEach(practices) { practice in
                if let measured = practice.measuredSpeakingShare {
                    LineMark(
                        x: .value("When", practice.createdAt),
                        y: .value("Spoke", measured * 100),
                        series: .value("Series", "actual")
                    )
                    // The LINE stays neutral. A series that crosses the ceiling has
                    // no single correct colour, and tinting the whole stroke by
                    // either token — including by the most recent point's side,
                    // which was the tempting shortcut — asserts that side for every
                    // point behind it, including the ones where it was false.
                    // Neutral here is not indecision; it is the only honest thing
                    // one stroke can say about both sides at once.
                    //
                    // `Color.primary`, NOT `.primary`. Bare `.primary` in a
                    // ShapeStyle position is `HierarchicalShapeStyle.primary` —
                    // "the primary level of the *current* foreground style" — and
                    // `OptiListenApp` sets `.tint(Theme.within)`, so it resolved to
                    // moss and drew this line green: a series crossing the ceiling
                    // asserting "within" for every point, which is the exact thing
                    // D-011 exists to prevent, arrived at by inheritance rather than
                    // by anyone choosing it. Caught 2026-09-24 by opening the image
                    // (D-017); it compiles clean either way and no grep for raw
                    // colours would ever have found it.
                    .foregroundStyle(Color.primary)

                    // The POINTS carry the semantic, each about itself, using the
                    // same pair as every numeral in the app (D-009). The most recent
                    // practice is the rightmost mark, where the eye lands first, so
                    // "how am I doing now" is answered at a glance without the line
                    // lying about last month. D-011.
                    PointMark(
                        x: .value("When", practice.createdAt),
                        y: .value("Spoke", measured * 100)
                    )
                    .foregroundStyle(practice.metGoal == true ? Theme.within : Theme.over)
                    .symbolSize(60)
                }
                LineMark(
                    x: .value("When", practice.createdAt),
                    y: .value("Goal", practice.goalSpeakingShare * 100),
                    series: .value("Series", "goal")
                )
                // `Color.secondary` for the same reason as the line above: bare
                // `.secondary` inherits the app tint and drew the ceiling in moss,
                // quietly colour-coding the reference line as "within".
                .foregroundStyle(Color.secondary)
                .lineStyle(StrokeStyle(dash: [4, 4]))
            }
        }
        .chartYAxisLabel("% spoken")
        .chartYScale(domain: 0...100)
        .chartLegend(.hidden)
    }
}
