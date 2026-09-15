# OptiListen — what needs xian

**Maintained by:** Cairn · **Updated:** 2026-09-14 (rev 16) · **Deadline:** 2026-11-24 (71 days · day 19 of 90 — still carried from the 08-26 notice; nobody has read it back from App Store Connect)

Canonical state. Janus may summarize this into the cross-project meta-rollup.
Rendered for xian as an artifact — https://claude.ai/code/artifact/54087bd3-f172-494f-b79b-49d3406f5215
(republish that same URL rather than creating a new one). This file is the source; the artifact follows it.
The artifact's HTML source lives beside this file at `docs/attention.html`.

> **rev 16: two builds shipped, zero hypotheses left, and the artifact that settles it has been sitting in Apple's console since 09-11.**
> 2.0 (2) went up on 09-14 at 17:07 with Pard's fix for the first-run microphone path. Apple finished
> processing at 17:11:55; xian installed it minutes later and **it crashed identically.** Janus proved
> the build identity from Apple's own timestamps rather than anyone's recollection, and Pard accepted
> the refutation without hedging. So the `sampleLevel` theory is dead, and we are at **zero**
> hypotheses — which is worse than it sounds, because the tempting next move is to invent another
> plausible story and ship against it. That is precisely how 09-12 through 09-14 were spent.
> **No third build ships without a stack trace.** The crash log exists; reading it is item 1.

---

## Needs you

| # | Item | Why it's yours | Cost | Blocking |
|---|---|---|---|---|
| 1 | **Sign in to App Store Connect** so Cairn can read the crash log — https://appstoreconnect.apple.com/apps/1593948410/testflight/crashes — a Chrome tab is already open there. Say "in" and Cairn reads the stack. | The API exposes the crash *submissions* but 404s on the log body; the stack is only behind the console login or Xcode → Window → Organizer → Crashes on Amber. **This one artifact ends a three-day loop.** The top frame separates an audio-session-deactivation-on-background story from a watchdog kill, and those need opposite fixes. | ~1 min | **everything.** Build 3, the working prototype, Dan's hands-on |
| 2 | **Send Dan the brochure** when you're ready — it's private until shared from the page's share menu. | Three futures laid out at equal weight, no recommendation, no ask at the end, per your call. It supersedes the earlier explainer page — send this one, not both. | ~1 min | nothing; it's FYI by design |

## Resolved this pass

- **2.0 (2) exists and shipped** — 09-14 17:07, delivery `0702a0ea`, 34 minutes from Janus's GO. It carries the four Info.plist keys verified in the artifact, and a real fix: `sampleLevel` now sits behind the same permission gate `start()` uses, and both tap sites refuse a 0 Hz format rather than raising an uncatchable exception.
- **The mic-usage-string theory was wrong, and Pard caught it before rebuilding.** He read the four keys out of the *accepted* IPA — all four present. 2.0 (1) was built from the already-fixed tree; `99a34bc` was the record of the fix, pushed after the upload. The commit graph read naturally and was not the artifact. My "ship regardless" instinct was correct *under my premise* and the premise was false.
- **The `sampleLevel` theory was also wrong, and the refutation was clean.** Janus: exactly one other "completed processing" mail exists for this app in the past week (2.0 (1), 09-11), so there was no older build to confuse it with. The build xian tested is the build Pard shipped.
- **The crash submissions were readable by API the whole time** — `GET /v1/apps/1593948410/betaFeedbackCrashSubmissions`, same key that mints profiles. Three of them, in xian's own words, the first dated **09-11 19:26: "crashed when it went to background."** Nobody fetched it for three days. It is now one of Pard's standing checks for this app.
- **The reproduction is specific and has been all along:** it crashes on going to background after completing the setup for a call — not on first-run permission. Both halves of that sentence were in the original report on 09-11.
- **Dan's brochure is built** — `docs/for-dan/three-futures-for-optilisten.html`. Three options at equal weight, no recommendation, no ask. Supersedes `what-optilisten-does-now.html`, which should not also be sent.

## In flight

| Owner | Item | Waiting on |
|---|---|---|
| **Cairn** | **Read the symbolicated crash log and produce a diagnosis with a stack behind it.** Nothing else in this table moves until this does. | item 1 — the ASC login |
| **Pard** | **Build 3, within the hour of a diagnosis.** Pipeline is warm; 34 minutes door to door, proven twice. Explicitly *not* authoring the next theory. | the stack |
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
