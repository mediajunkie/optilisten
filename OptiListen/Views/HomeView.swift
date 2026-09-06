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

    @State private var source = LiveMicSource()
    @State private var showingLoop = false
    @State private var showingCalibration = false

    private var closed: [Practice] { practices.filter(\.isComplete) }
    private var unreflected: [Practice] { practices.filter { $0.intentionSetAt != nil && $0.reflectedAt == nil } }
    private var withEvidence: [Practice] { closed.filter(\.hasEvidence) }

    var body: some View {
        NavigationStack {
            List {
                Section {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("\(closed.count)")
                            .font(.system(size: 52, weight: .light, design: .rounded))
                            .monospacedDigit()
                            .contentTransition(.numericText())
                        Text(closed.count == 1 ? "conversation practiced" : "conversations practiced")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 8)
                    .listRowSeparator(.hidden)
                }

                if !unreflected.isEmpty {
                    Section {
                        ForEach(unreflected) { practice in
                            NavigationLink {
                                Text("Reflection for \(practice.label)")  // wired in next pass
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
                        ForEach(closed.prefix(12)) { practice in
                            PracticeRow(practice: practice)
                        }
                    }
                }

                if practices.isEmpty {
                    Section {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Set an intention before your next conversation.")
                                .font(.headline)
                            Text("Decide how much you mean to talk and what you're practicing. Have the conversation. Come back and say how it went. That loop is the whole thing — the microphone is optional.")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.vertical, 8)
                    }
                }
            }
            .navigationTitle("OptiListen")
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
                        .foregroundStyle(practice.metGoal == true ? .green : .orange)
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
                    .foregroundStyle(.orange)
                    .symbol(.circle)
                }
                LineMark(
                    x: .value("When", practice.createdAt),
                    y: .value("Goal", practice.goalSpeakingShare * 100),
                    series: .value("Series", "goal")
                )
                .foregroundStyle(.secondary)
                .lineStyle(StrokeStyle(dash: [4, 4]))
            }
        }
        .chartYAxisLabel("% spoken")
        .chartYScale(domain: 0...100)
        .chartLegend(.hidden)
    }
}
