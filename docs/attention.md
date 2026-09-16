# OptiListen — what needs xian

**Maintained by:** Cairn · **Updated:** 2026-09-16 (rev 18) · **Deadline:** 2026-11-24 (69 days · day 21 of 90 — still carried from the 08-26 notice; nobody has read it back from App Store Connect)

Canonical state. Janus may summarize this into the cross-project meta-rollup.
Rendered for xian as an artifact — https://claude.ai/code/artifact/54087bd3-f172-494f-b79b-49d3406f5215
(republish that same URL rather than creating a new one). This file is the source; the artifact follows it.
The artifact's HTML source lives beside this file at `docs/attention.html`.

> **rev 18: the fix is pushed and 2.0 (3) is Pard's to build — still nothing waiting on you.** The
> tap closure in `LiveMicSource.start()` is now `@Sendable`, which makes it *nonisolated*. The
> defect was never the `guard let self`: a closure written inside a `@MainActor` class and **not**
> marked `@Sendable` **inherits that isolation**, so Swift 6 compiled a hard
> `_swift_task_checkIsolated` precondition into its entry — and that precondition is the
> `dispatch_assert_queue_fail` at the top of Pard's trace. It fired before the first line of the
> body ran. The block now touches nothing isolated and hands a plain `Double` to the actor, which
> is the shape calibration's tap always had; the two sites finally agree on the only property that
> mattered. `fc806dd`, plus `ed10b05` for the same pattern in the interruption observer and
> `0ea5f9f` bumping the build number to 3 so the upload has a number of its own.
>
> **One caveat worth your eyes: I could not compile it.** kindbook has no SDK, so this is
> syntax-checked and nothing more. Amber's build is the first real test — and a green build still
> proves less than a phone does, because an isolation assert is a *runtime* precondition. The proof
> is the practice loop starting on a device and not trapping.
>
> **And the honest part: this sat for 58 hours.** Rev 17 said the design call was mine, and then the
> session ended without landing it. Pard had the elapsed figure in his 09-15 log before I did. A
> claim in this rollup reads exactly like work in progress and is not work in progress — that is now
> a rule I hold rather than a thing that happened.
---

## Needs you

| # | Item | Why it's yours | Cost | Blocking |
|---|---|---|---|---|
| 1 | **Send Dan the brochure** when you're ready — it's private until shared from the page's share menu. | Three futures laid out at equal weight, no recommendation, no ask at the end, per your call. It supersedes the earlier explainer page — send this one, not both. | ~1 min | nothing; it's FYI by design |

## Resolved this pass

- **The isolation fix is landed — `fc806dd`.** `start()`'s tap is `@Sendable` and therefore
  nonisolated; it computes the level through the `nonisolated static` and hops to the main actor
  carrying a `Double`. `ed10b05` applies the same attribute to the `NotificationCenter` interruption
  block, which has the identical shape and survives today only because `queue: .main` happens to land
  it on the main queue — it is a separate commit precisely so Pard can drop it alone if the SDK
  already types that block `@Sendable`. `0ea5f9f` bumps `CURRENT_PROJECT_VERSION` to `3`: build 2 is
  spent on the crashing upload, and that one line is what bit us last round.
- **Why `@Sendable`, and not either of the other two shapes Pard offered.** A `nonisolated`
  `classify` over a lock would make every view read of the counters acquire a lock and would cost
  `@Observable` its single-threaded story — an architecture change bought to fix a one-attribute
  defect. A counters actor looks symmetrical with `Samples` and isn't: `Samples` is write-only during
  capture and read exactly once at the end, while the live counters are read continuously by the UI,
  so an actor forces a `@MainActor` mirror — and **a mirror is a second source of truth that can
  lag.** For an app whose whole premise is that a confident wrong number is worse than an honest
  partial one, a drift-capable copy of the number does not go on the screen. **State stays where it
  is; the isolation moves.**
- **Pard's `df2997b` guards stay.** The permission gate on `sampleLevel` and the 0 Hz refusal fixed a
  real defect that was never this one. Not reverted, and not wanted reverted.

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
| **Pard** | **Build and ship 2.0 (3).** The fix is on `origin/main` at `0ea5f9f`; build, standing artifact check, binary grep, upload. 34 minutes, warm, proven twice. **This is also the first real compile of the change — kindbook could only parse it.** | nothing — it's the critical path |
| **Pard** | Then pull the crash submission with the standing `/crashLog` capability rather than waiting on xian to describe it | a build on a phone |
| **Pard** | Re-check the removal date in App Store Connect now that two builds have been accepted — did the grace-period notice move? | a natural moment in the console |
| **Cairn** | Update the Dan brochure once a build survives use — the "it crashes" line comes out of the Not-yet column and the prototype goes to his phone | build 3 working |
| **Cairn** | Deferred-reflection resume flow in `HomeView`; calibration persistence | not blocked; the crash first |
| **Janus** | Registry: two entries — `mediajunkie/optilisten` (app) and `Design-in-Product/optilisten` (live site) | memo 09-07; unconfirmed |
| **open** | Whether Cairn runs as Cowork or Code, and on which machine | xian; not urgent |

## Standing risks

- **Two builds shipped against two theories before anything was diagnosed; build 3 is the first that ships against a stack.** Both earlier theories were real defects; neither was the one. **The risk is not retired until a phone runs build 3** — a trace names a cause, and a cause is not yet a cure. The pattern to break is reasoning from source to a mechanism we can *see*, when the reporter has already named a mechanism we'd have to go look for. Pard's own rule, adopted here: **when a report names two things and you can only explain one, the one you can't explain is the finding.**
- **No instrumentation.** Every crash this month was found because a human installed a build and hit it. There is no crash reporting in the app and no alert when a submission lands. xian raised this on 09-14 and today is the argument for it.
- **Compiling is not running, and running is not being used.** 2.0 has been launched on a real phone twice and died both times. Nobody has yet watched calibration, the mic tap, or the loop behave in an actual conversation.
- **Calibration is `Codable` and nothing persists it** — recalibrates every cold launch.
- **The fleet has one signing path and it expires Aug 2027.** The API can renew it; nothing watches for expiry.
- **The 24 Nov date is still the screenshot, not an ASC readback.** The forward works; nobody has looked. Two accepted builds may well have moved it.
- **Apple has rejected this app once before** (July 2023, background modes). 2.0 omits `UIBackgroundModes` — which is also, possibly, the thing making it crash. If the fix needs an audio background mode, that is a submission-risk conversation, not just a code change.
- **Age-rating social-media questions** at submission; ~10 min; answers are "no."
- **A claim in this rollup is not a commit.** Rev 17 marked the isolation fix as mine and owned; the fix then sat unwritten for 58 hours while the row read — to Pard, to Janus, and to the next instance of me — exactly like work in progress. Ownership recorded here now has to be followed in the same fire by either the work or a stated hand-off.
