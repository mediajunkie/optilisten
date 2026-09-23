#if DEBUG
import Foundation
import SwiftData

/// Screenshot scaffolding for the App Store art. Compiled into Debug builds only
/// and driven by launch arguments, so a Release build, TestFlight, and every
/// ordinary launch of a Debug build never see any of it.
///
///     -screenshot-fixture <share>    listening screens show this share of talking (0.0–1.0)
///     -screenshot-elapsed <seconds>  how far into the conversation the clock reads (default 390)
///     -screenshot-seed               Home shows six closed practices drifting down toward a 30% ceiling
///     -screenshot-focus <text>       the practice loop opens with this focus line already written
///     -screenshot-label <text>       … and this conversation label
///     -screenshot-presence <1-5>     … and this presence already chosen on the reflection screen
///     -screenshot-step <step>        open the loop on launch at intention | listening | reflection
///
/// Capture, from a booted Simulator with a Debug build installed:
///
///     xcrun simctl launch booted com.longskymedia.optilisten -screenshot-fixture 0.22 -screenshot-elapsed 390
///     xcrun simctl io booted screenshot shot-3-listening-within.png
///
/// The six-shot sequence and what each must show is `docs/store-content-2.0.md` §3.
enum ScreenshotFixture {

    private static var arguments: [String] { ProcessInfo.processInfo.arguments }

    private static func value(after flag: String) -> String? {
        guard let index = arguments.firstIndex(of: flag),
              arguments.indices.contains(index + 1) else { return nil }
        return arguments[index + 1]
    }

    /// The source Home hands to the practice loop: the real microphone unless the
    /// fixture argument is present.
    @MainActor
    static func source() -> LiveMicSource {
        guard let raw = value(after: "-screenshot-fixture"), let share = Double(raw) else {
            return LiveMicSource()
        }
        let elapsed = value(after: "-screenshot-elapsed").flatMap(Double.init) ?? 390
        return LiveMicSource.screenshotFixture(share: min(max(share, 0), 1), elapsed: elapsed)
    }

    /// Which step of the loop to open on launch, or nil to land on Home as usual.
    /// Nothing in the Simulator can tap "Begin" for us, so this is what makes
    /// shots 2–5 capturable from a script instead of a hand on the screen.
    static var initialStep: String? {
        guard let step = value(after: "-screenshot-step"),
              ["intention", "listening", "reflection"].contains(step) else { return nil }
        return step
    }

    /// The practice the loop opens with: empty unless the focus/label/presence
    /// arguments are present, so shots 2–5 need no typing in the Simulator.
    @MainActor
    static func prefilledPractice() -> Practice {
        let practice = Practice(
            label: value(after: "-screenshot-label") ?? "",
            goalSpeakingShare: 0.30,
            focus: value(after: "-screenshot-focus") ?? ""
        )
        if let raw = value(after: "-screenshot-presence"), let presence = Int(raw), (1...5).contains(presence) {
            practice.presence = presence
        }
        return practice
    }

    /// Six closed practices over three weeks with a visible downward drift, so
    /// shot 6 has a counter, a Recent list, and a populated goal chart. Inserts
    /// only into an empty store: a device with real history is never touched.
    @MainActor
    static func seedIfRequested(into context: ModelContext, existing: Int) {
        guard arguments.contains("-screenshot-seed"), existing == 0 else { return }

        let rows: [(daysAgo: Int, label: String, focus: String, share: Double, presence: Int, note: String)] = [
            (20, "Roadmap review",       "Ask before answering.",   0.58, 2, "Jumped in on every question. Noticed it halfway through."),
            (17, "1:1 with a report",    "Let silences run.",       0.51, 3, "Two long pauses. Both went somewhere."),
            (13, "Customer call",        "One question, then wait.", 0.44, 3, "Better. Still finished their sentences twice."),
            (9,  "Planning",             "Summarize before I add.", 0.39, 4, "Repeated back first. The room slowed down."),
            (5,  "Board prep with xian", "Ask before answering.",   0.33, 4, "Close to the ceiling. Felt present."),
            (1,  "Design critique",      "Let silences run.",       0.27, 5, "Under the line. Heard the thing I'd have talked over."),
        ]

        for row in rows {
            let practice = Practice(label: row.label, goalSpeakingShare: 0.30, focus: row.focus)
            let created = Calendar.current.date(byAdding: .day, value: -row.daysAgo, to: .now) ?? .now
            let duration: TimeInterval = 1_800
            let speech = duration * 0.85
            practice.createdAt = created
            practice.intentionSetAt = created
            practice.userSpeakingSeconds = speech * row.share
            practice.otherSpeakingSeconds = speech * (1 - row.share)
            practice.silenceSeconds = duration - speech
            practice.measuredSpeakingShare = row.share
            practice.evidenceDuration = duration
            practice.evidenceSourceID = "live-mic"
            practice.conversationDuration = duration
            practice.presence = row.presence
            practice.note = row.note
            practice.reflectedAt = created.addingTimeInterval(duration + 120)
            context.insert(practice)
        }
    }
}
#endif
