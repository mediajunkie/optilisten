import Foundation

/// The user tells us what they observed.
///
/// Not a fallback — the honest default. Most conversations worth practicing on
/// are not recorded, not on Zoom, and not something you'd set a phone beside:
/// a hallway conversation, a difficult one-on-one, dinner. The loop still works.
/// You set an intention, you have the conversation, you say roughly how it went.
///
/// A rough self-reported number that closes the loop beats a precise number that
/// only exists for the subset of conversations a microphone could reach.
struct ManualSource: TalkRatioSource {
    let id = "manual"
    let displayName = "Your estimate"
    func isAvailable() async -> Bool { true }
}

/// Adapter over Granola's notes API.
///
/// **Status: not wired up, and deliberately so.** Verified 2026-09-06:
/// API keys require a Business plan, and transcript access is paid-tier only —
/// a request against a free account returns "Transcripts are only available to
/// paid Granola tiers." So this cannot be the product's spine.
///
/// It stays in the tree as a shaped placeholder because the protocol boundary is
/// the point: if access opens up, or if the user is on a Business plan, this
/// becomes real without anything downstream changing.
///
/// The mechanics, when it is built: Granola returns transcript segments carrying
/// a `speaker.source` of microphone or system audio on macOS, which maps cleanly
/// to user-versus-other. iOS notes carry only `diarization_label` (Speaker A/B)
/// from a single audio stream, which does *not* — there is no way to know which
/// anonymous speaker is the user, so iOS-captured notes must be refused rather
/// than guessed at.
struct GranolaSource: RetrospectiveTalkRatioSource {
    let id = "granola"
    let displayName = "Granola"

    var apiKey: String?

    func isAvailable() async -> Bool {
        guard apiKey != nil else { return false }
        return false // Not implemented; see note above.
    }

    func availableConversations(since: Date) async throws -> [ConversationRecord] {
        throw TalkRatioSourceError.unavailableOnThisPlan("Granola")
    }

    func evidence(for record: ConversationRecord) async throws -> TalkEvidence? {
        throw TalkRatioSourceError.unavailableOnThisPlan("Granola")
    }
}

/// Registry of what this build can offer, in the order the UI should present it.
///
/// Availability is asked at runtime rather than assumed, so a user who denies
/// microphone access simply sees a shorter list instead of a broken screen.
@MainActor
struct SourceRegistry {
    let live: LiveMicSource
    let manual = ManualSource()
    var granola = GranolaSource()

    func availableSources() async -> [any TalkRatioSource] {
        var result: [any TalkRatioSource] = []
        if await live.isAvailable() { result.append(live) }
        if await granola.isAvailable() { result.append(granola) }
        result.append(manual) // always last, always present
        return result
    }
}
