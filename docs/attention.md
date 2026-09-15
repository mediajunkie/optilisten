# OptiListen — what needs xian

**Maintained by:** Cairn · **Updated:** 2026-09-14 (rev 17) · **Deadline:** 2026-11-24 (71 days · day 19 of 90 — still carried from the 08-26 notice; nobody has read it back from App Store Connect)

Canonical state. Janus may summarize this into the cross-project meta-rollup.
Rendered for xian as an artifact — https://claude.ai/code/artifact/54087bd3-f172-494f-b79b-49d3406f5215
(republish that same URL rather than creating a new one). This file is the source; the artifact follows it.
The artifact's HTML source lives beside this file at `docs/attention.html`.

> **rev 17: the stack exists and the cause is named — nothing is waiting on you.** Pard pulled the
> symbolicated log by API after all: his `/crashLog` 404 was **a truncated submission ID**, not a
> missing resource — he had printed `id[:12]` for readability in an earlier probe and then used the
> printed string as the identifier. With the full ID it returns 200 and 23,762 bytes of `logText`.
> **No console login, no Organizer, no signed-in Xcode. Item 1 on rev 16 asked you for something that
> was never needed.** The crash is a **Swift 6 actor-isolation assert** — `EXC_BREAKPOINT`, not memory
> corruption — firing on AVFAudio's real-time thread inside `start()`'s tap closure. The next move is
> a design call, and it's mine.
---

## Needs you

| # | Item | Why it's yours | Cost | Blocking |
|---|---|---|---|---|
| 1 | **Send Dan the brochure** when you're ready — it's private until shared from the page's share menu. | Three futures laid out at equal weight, no recommendation, no ask at the end, per your call. It supersedes the earlier explainer page — send this one, not both. | ~1 min | nothing; it's FYI by design |

## Resolved this pass

- **The stack, and the cause.** `EXC_BREAKPOINT (SIGTRAP)` on thread 2, version 2.0 (2). Bottom-up: AVFAudio delivers a buffer on its real-time messenger queue → calls the tap block → the block touches `self` → `swift_task_isCurrentExecutorWithFlagsImpl` → `_dispatch_assert_queue_fail`. `LiveMicSource` is `@MainActor`; the tap callback runs off it; `guard let self` touches main-actor-isolated state from the audio thread, and under `SWIFT_STRICT_CONCURRENCY: complete` on Swift 6 that check is a **hard trap, not a warning**.
- **Why it was never `sampleLevel` — the discriminator nobody saw.** Calibration's tap captures *no* `self`: it closes over a local `Samples` actor and calls a `static`. `start()`'s tap captures `self`. **The two tap sites look almost identical and differ on the only thing that matters.** Pard's two guards went into both and touched neither — the isolation assert sits *above* his guard in the same function. They fixed a real defect that was never this one.
- **And it explains the report exactly.** `start()` is called from `PracticeLoopView.swift:198` — *after* setup — and the first buffers arrive moments later. Not the backgrounding as such: the practice loop starting. xian's "as soon as I fill out the first screen and it tries to go to background" was one event described from the outside.
- **"Needs the console login" was a capability limit that didn't exist.** Pard's third error of the week and the same shape as the other two: *a reading of his own output mistaken for a reading of the world.* He named it himself before anyone asked.
- **Crash-log fetch is now a standing capability** — `/v1/betaFeedbackCrashSubmissions/{full-id}/crashLog` returns `logText` inline. Pard pulls it automatically on any future TestFlight crash for this app and puts the trace in front of whoever owns the fix.

- **2.0 (2) exists and shipped** — 09-14 17:07, delivery `0702a0ea`, 34 minutes from Janus's GO. It carries the four Info.plist keys verified in the artifact, and a real fix: `sampleLevel` now sits behind the same permission gate `start()` uses, and both tap sites refuse a 0 Hz format rather than raising an uncatchable exception.
- **The mic-usage-string theory was wrong, and Pard caught it before rebuilding.** He read the four keys out of the *accepted* IPA — all four present. 2.0 (1) was built from the already-fixed tree; `99a34bc` was the record of the fix, pushed after the upload. The commit graph read naturally and was not the artifact. My "ship regardless" instinct was correct *under my premise* and the premise was false.
- **The `sampleLevel` theory was also wrong, and the refutation was clean.** Janus: exactly one other "completed processing" mail exists for this app in the past week (2.0 (1), 09-11), so there was no older build to confuse it with. The build xian tested is the build Pard shipped.
- **The crash submissions were readable by API the whole time** — `GET /v1/apps/1593948410/betaFeedbackCrashSubmissions`, same key that mints profiles. Three of them, in xian's own words, the first dated **09-11 19:26: "crashed when it went to background."** Nobody fetched it for three days. It is now one of Pard's standing checks for this app.
- **The reproduction is specific and has been all along:** it crashes on going to background after completing the setup for a call — not on first-run permission. Both halves of that sentence were in the original report on 09-11.
- **Dan's brochure is built** — `docs/for-dan/three-futures-for-optilisten.html`. Three options at equal weight, no recommendation, no ask. Supersedes `what-optilisten-does-now.html`, which should not also be sent.

## In flight

| Owner | Item | Waiting on |
|---|---|---|
| **Cairn** | **Choose and push the isolation fix.** The trace names the closure, but there are at least three defensible shapes — make the tap capture nothing isolated and hop to the actor with the value; make `classify` `nonisolated` over a lock; move level state into a dedicated actor as `Samples` already is. **Picking among them is a design call about where this class's state should live, which is why Pard declined to make it.** | nothing — it's the critical path |
| **Pard** | **Build 3 the moment the fix is pushed** — build, standing artifact check, binary grep, upload. 34 minutes, warm, proven twice. | Cairn's push |
| **Pard** | Re-check the removal date in App Store Connect now that two builds have been accepted — did the grace-period notice move? | a natural moment in the console |
| **Cairn** | Candidate to test *against the log, not instead of it*: nothing in the tree observes `scenePhase` or `didEnterBackground`, `stop()` is only called from a view action at `PracticeLoopView.swift:57`, and the app declares no `UIBackgroundModes` — so a running engine has nothing deactivating it when the app backgrounds. **A story with a code path attached, which is exactly what the last two were.** | the stack |
| **Cairn** | Update the Dan brochure once a build survives use — the "it crashes" line comes out of the Not-yet column and the prototype goes to his phone | build 3 working |
| **Cairn** | Deferred-reflection resume flow in `HomeView`; calibration persistence | not blocked; the crash first |
| **Janus** | Registry: two entries — `mediajunkie/optilisten` (app) and `Design-in-Product/optilisten` (live site) | memo 09-07; unconfirmed |
| **open** | Whether Cairn runs as Cowork or Code, and on which machine | xian; not urgent |

## Standing risks

- **We have shipped two builds against two theories and diagnosed nothing.** Both theories were real defects; neither was the one. The pattern to break is reasoning from source to a mechanism we can *see*, when the reporter has already named a mechanism we'd have to go look for. Pard's own rule, adopted here: **when a report names two things and you can only explain one, the one you can't explain is the finding.**
- **No instrumentation.** Every crash this month was found because a human installed a build and hit it. There is no crash reporting in the app and no alert when a submission lands. xian raised this on 09-14 and today is the argument for it.
- **Compiling is not running, and running is not being used.** 2.0 has been launched on a real phone twice and died both times. Nobody has yet watched calibration, the mic tap, or the loop behave in an actual conversation.
- **Calibration is `Codable` and nothing persists it** — recalibrates every cold launch.
- **The fleet has one signing path and it expires Aug 2027.** The API can renew it; nothing watches for expiry.
- **The 24 Nov date is still the screenshot, not an ASC readback.** The forward works; nobody has looked. Two accepted builds may well have moved it.
- **Apple has rejected this app once before** (July 2023, background modes). 2.0 omits `UIBackgroundModes` — which is also, possibly, the thing making it crash. If the fix needs an audio background mode, that is a submission-risk conversation, not just a code change.
- **Age-rating social-media questions** at submission; ~10 min; answers are "no."
