import Foundation
import SwiftData

/// A single rehearsal of listening: an intention set before a conversation,
/// optional evidence gathered during it, and a reflection made after.
///
/// The unit of the product is the *loop*, not the measurement. A practice with
/// an intention and a reflection but no measured ratio is complete. A practice
/// with a perfect ratio and no reflection is not.
@Model
final class Practice {

    // MARK: Identity

    var id: UUID = UUID()
    var createdAt: Date = Date()

    /// What the conversation was, in the user's words. Optional on purpose —
    /// requiring a label before you can start is friction at exactly the moment
    /// the user is about to join a call.
    var label: String = ""

    // MARK: 1. Intention — set before

    /// Share of the conversation the user intends to spend speaking, 0.0–1.0.
    /// Named as a ceiling rather than a target: the practice is restraint.
    var goalSpeakingShare: Double = 0.30

    /// One line, in the user's own words, about what they're practicing.
    /// "Ask before answering." "Let silences run." This is the part that makes
    /// the loop a rehearsal instead of a report.
    var focus: String = ""

    var intentionSetAt: Date?

    // MARK: 2. Evidence — gathered during, optional by design

    /// Measured share of speaking time, 0.0–1.0, if any source produced one.
    /// Nil is a first-class state: the user practiced without instrumentation.
    var measuredSpeakingShare: Double?

    /// Which source produced `measuredSpeakingShare`, for honest display.
    /// Stored as a raw value so the model stays portable across sources.
    var evidenceSourceID: String?

    /// Wall-clock seconds the evidence covers. A ratio from four minutes of a
    /// sixty-minute call is not the same claim as a ratio from the whole thing,
    /// and the UI must never pretend otherwise.
    var evidenceDuration: TimeInterval = 0

    /// Length of the conversation as the user reports it, when known. Lets the
    /// UI say "we heard 8 of your 45 minutes" instead of implying full coverage.
    var conversationDuration: TimeInterval?

    // MARK: 3. Reflection — made after

    /// 1–5, the user's own read on how present they were. Deliberately
    /// subjective and deliberately not derived from the ratio: you can hit
    /// twenty percent and still be somewhere else entirely.
    var presence: Int?

    /// Free text. Where the actual learning lives.
    var note: String = ""

    var reflectedAt: Date?

    init(
        label: String = "",
        goalSpeakingShare: Double = 0.30,
        focus: String = ""
    ) {
        self.id = UUID()
        self.createdAt = Date()
        self.label = label
        self.goalSpeakingShare = goalSpeakingShare
        self.focus = focus
    }
}

// MARK: - Derived state

extension Practice {

    /// The loop is closed when an intention was set and a reflection was made.
    /// Measurement is evidence, not a requirement — this is the definition the
    /// whole product hangs on.
    var isComplete: Bool {
        intentionSetAt != nil && reflectedAt != nil
    }

    var hasEvidence: Bool {
        measuredSpeakingShare != nil && evidenceDuration > 0
    }

    /// Signed distance from the goal. Negative means the user spoke less than
    /// they intended. Nil when there's no evidence to compare against.
    var goalDelta: Double? {
        guard let measured = measuredSpeakingShare else { return nil }
        return measured - goalSpeakingShare
    }

    var metGoal: Bool? {
        guard let delta = goalDelta else { return nil }
        return delta <= 0
    }

    /// What fraction of the conversation the evidence actually covers, 0.0–1.0.
    /// Nil when the user never said how long the conversation was.
    ///
    /// This exists because OptiListen 1.x shipped a ratio derived from as little
    /// as fifty seconds of a meeting and presented it with the same confidence
    /// as a full reading. Never again: coverage travels with the number.
    var evidenceCoverage: Double? {
        guard let total = conversationDuration, total > 0 else { return nil }
        return min(evidenceDuration / total, 1.0)
    }

    /// Whether the evidence is thin enough that the UI should hedge the number.
    var evidenceIsPartial: Bool {
        guard let coverage = evidenceCoverage else { return evidenceDuration < 300 }
        return coverage < 0.8
    }
}

// MARK: - Formatting helpers

extension Practice {

    var goalPercentText: String { Self.percent(goalSpeakingShare) }

    var measuredPercentText: String? {
        measuredSpeakingShare.map(Self.percent)
    }

    static func percent(_ share: Double) -> String {
        "\(Int((share * 100).rounded()))%"
    }
}
