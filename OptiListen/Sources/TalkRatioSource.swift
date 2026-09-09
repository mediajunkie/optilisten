import Foundation

/// Where a speaking-share number comes from.
///
/// OptiListen 1.x fused measurement and product: the app *was* the microphone,
/// so when the microphone hit an OS limit the product hit it too. 2.0 keeps them
/// apart. The practice loop never talks to a microphone; it asks a source for
/// evidence, and every source is optional.
///
/// Three kinds exist or are planned:
///
/// - `LiveMicSource` — on-device, foreground, ships now.
/// - `ManualSource` — the user types what they observed. Always available,
///   never fails, and is the honest default for a conversation nobody recorded.
/// - Adapters over meeting tools that already compute talk ratio (Granola, Gong).
///   Verified 2026-09-06: Granola's API requires a Business plan and transcripts
///   are paid-tier only; Zoom exposes no speaking-time endpoint at all. So these
///   are written as adapters behind this protocol rather than as the product's
///   spine — if that access opens up, they slot in; if it never does, nothing
///   downstream changes.
protocol TalkRatioSource: Sendable {

    /// Stable identifier persisted on `Practice.evidenceSourceID`.
    var id: String { get }

    /// Shown to the user next to any number this source produced. Provenance is
    /// part of the reading, not a footnote.
    var displayName: String { get }

    /// Whether this source can run right now — permissions, plan, connectivity.
    /// Sources are expected to answer honestly and fast; the UI asks on every
    /// appearance and hides what can't run rather than failing later.
    func isAvailable() async -> Bool
}

/// A source that produces evidence live, while the conversation happens.
///
/// The two synchronous readings below are `@MainActor`. That is a design
/// statement, not a compiler appeasement: a live reading exists to be shown
/// while it changes, so it is read by SwiftUI on the main actor and nowhere
/// else. Leaving them nonisolated would have let a caller sample a share
/// mid-update from another thread and render a number the source never held.
///
/// `start()`, `stop()` and `isAvailable()` stay nonisolated deliberately —
/// they are `async`, so an isolated conformer satisfies them by hopping, and
/// a future source is free to do its lifecycle work off the main actor.
protocol LiveTalkRatioSource: TalkRatioSource {

    /// Current best estimate of the user's speaking share, 0.0–1.0.
    @MainActor var currentShare: Double { get }

    /// Seconds of conversation this source has actually observed. Not elapsed
    /// wall-clock — the two diverge the moment the OS suspends anything, and
    /// conflating them is how 1.x reported a confident ratio from fifty seconds.
    @MainActor var observedDuration: TimeInterval { get }

    func start() async throws
    func stop() async
}

/// A source that produces evidence after the fact, from a record of the
/// conversation someone else already made.
protocol RetrospectiveTalkRatioSource: TalkRatioSource {

    /// Conversations this source can offer evidence for, most recent first.
    func availableConversations(since: Date) async throws -> [ConversationRecord]

    /// Evidence for one conversation, or nil when the record exists but carries
    /// no usable speaker attribution.
    func evidence(for record: ConversationRecord) async throws -> TalkEvidence?
}

// MARK: - Transfer types

struct ConversationRecord: Identifiable, Hashable, Sendable {
    let id: String
    let title: String
    let startedAt: Date
    let duration: TimeInterval?
}

struct TalkEvidence: Sendable {
    /// User's share of speaking time, 0.0–1.0.
    let speakingShare: Double
    /// Seconds of conversation the evidence actually covers.
    let observedDuration: TimeInterval
    /// Full length of the conversation, when the source knows it.
    let conversationDuration: TimeInterval?
    let sourceID: String
}

enum TalkRatioSourceError: LocalizedError {
    case permissionDenied
    case unavailableOnThisPlan(String)
    case noSpeakerAttribution
    case interrupted

    var errorDescription: String? {
        switch self {
        case .permissionDenied:
            "OptiListen needs microphone access to listen along."
        case .unavailableOnThisPlan(let service):
            "\(service) doesn't make talk-time available on this account."
        case .noSpeakerAttribution:
            "That recording doesn't say who was speaking, so there's no ratio to read."
        case .interrupted:
            "Listening stopped early, so this reading covers only part of the conversation."
        }
    }
}
