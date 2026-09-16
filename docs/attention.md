# OptiListen — what needs xian

**Maintained by:** Cairn · **Updated:** 2026-09-16 (rev 19) · **Deadline:** 2026-11-24 (69 days · day 21 of 90 — still carried from the 08-26 notice; nobody has read it back from App Store Connect)

Canonical state. Janus may summarize this into the cross-project meta-rollup.
Rendered for xian as an artifact — https://claude.ai/code/artifact/54087bd3-f172-494f-b79b-49d3406f5215
(republish that same URL rather than creating a new one). This file is the source; the artifact follows it.
The artifact's HTML source lives beside this file at `docs/attention.html`.

> **rev 19: 2.0 (3) tracks nothing and still dies — and the fourth theory is not being written.**
> xian's report: it didn't crash immediately the way (2) did, but it never started tracking, and it
> crashed eventually in a similar way. His read — whack-a-mole, look at the architecture or the
> execution — is correct, and a full read of the capture path says why in one sentence.
>
> **`PracticeLoopView.swift:198` is `try? await source.start()`, and `start()` has four throw
> sites.** All four are discarded there. The view then renders `currentShare`, which is `0` when no
> buffer ever arrives — so **a failed start is pixel-identical to a working start in a quiet room**,
> and which of the four threw is unknowable from outside the process. `CalibrationView` does the
> same one level worse: its `?? -20` / `?? -50` fallbacks build a `Calibration` numerically
> identical to `.unavailable` — and **`.unavailable.isUsable` is `true`** — so a total calibration
> failure is indistinguishable from a successful one.
>
> **Root cause, and it implicates the process as much as the code: nothing in this loop has ever
> required the app to report its own state.** Written without a device, verified by reading,
> compiled on a machine that can't run it, shipped to a tester whose only instrument is "it
> crashed." With no observability, every defect must be diagnosed by inference from source — which
> is exactly where Pard and I have each failed three times this month. **The whack-a-mole isn't bad
> luck; it's what this architecture plus this process necessarily produces.**
>
> **So the next build should report rather than fix.** One build: every `try?` and `??` in the
> capture path replaced by a rendered state, a `CaptureState` enum with `.failed(String)`, and a
> rolling in-app event log xian can copy out. It converts every remaining bug from an inference
> problem into a reading problem, once. Full writeup and five more defects found on the way:
> `docs/architecture-review-2026-09-16.md`.
---

## Needs you

| # | Item | Why it's yours | Cost | Blocking |
|---|---|---|---|---|
| 1 | **Send me Dan's feedback on the AI writing tics** — you said you'd share it. | It's the only thing that improves the brochure, and the same tics are presumably in everything else I write for you to send. I'd rather fix the class than the instance. | ~1 min | a corrected brochure, and my prose generally |
| 2 | **Nothing else.** Pard fetches the new crash log; the next build is a diagnostic build, not a fix. | Item 1 aside, the loop runs without you until there's something to install. | — | — |

## A live strategic option, not yet a recommendation

**Live capture is not required for App Store compliance and is not required for the product
argument.** The loop closes on intention + reflection, `ManualSource` exists, and
`Practice.isComplete` ignores measurement by design. So there is a shippable build with the
microphone behind a flag and the manual number as the only path: Apple satisfied, capture off the
critical path. It trades a working prototype in Dan's hands for certainty against 24 November.
**69 days and three failed builds is the reason it's on the table now rather than discovered in
November.**

## Resolved this pass

- **The five-whys is done and the root cause is named** — `docs/architecture-review-2026-09-16.md`.
  Every defect this month (missing usage string → 0 Hz tap → isolation trap → tracks nothing)
  presents identically: the app dies or does nothing and tells no one why. One property, four
  symptoms.
- **Five more defects found by reading rather than by crashing:** `.unavailable` passes `isUsable`
  (30 dB gap against an 8 dB threshold); `stop()` is unreachable after a failed `start()` because
  `isRunning = true` is the last line and `stop()` guards on it; `observeInterruptions()` adds an
  observer on every `start()` and discards the token so it can never be removed; time accounting is
  buffer-count × 0.1s rather than elapsed seconds, which makes `evidenceCoverage` a fiction that
  looks like a measurement; one `AVAudioEngine` has two owners and no arbitration. **None of these
  is being proposed as the crash.**
- **2.0 (3) built, archived and uploaded** — delivery `30256500`, `ARCHIVE SUCCEEDED`, zero new
  warnings, artifact-checked. The `@Sendable` fix compiles clean, which was the open question I
  couldn't answer from kindbook.
- **Pard retracted his own binary check as vacuous before reporting it as verification** — he ran it
  against the 2.0 (2) binary, which demonstrably crashes on that assert, and got the same `0`. The
  rule survives; his implementation didn't discriminate. Keeping the previous IPA on disk is what
  made the control possible, and is now standing practice.

## In flight

| Owner | Item | Waiting on |
|---|---|---|
| **Pard** | **Fetch the new crash submission for 2.0 (3)** — full ID, `/v1/betaFeedbackCrashSubmissions/{id}/crashLog`, his standing capability. **And the submission text, not just the stack:** whether xian's own words name a different moment than "going to background" matters as much as the trace, and that is the half we dropped last week. | memo sent 09-16; asked explicitly not to build anything yet |
| **Cairn** | **The diagnostic build.** Every `try?` and `??` in the capture path replaced by a rendered state; `CaptureState` enum with `.failed(String)`; a rolling in-app event log (start, permission result, sample rate, frames per buffer, buffers received, every error) xian can copy out of the app. **No crash fix in it.** | the crash log, so the instrumentation covers what actually failed |
| **Cairn** | `calibration: Calibration?` and delete `.unavailable`; make "I don't know" representable | folds into the diagnostic build |
| **Cairn** | Lifecycle state machine, one engine owner, `stop()` reachable from every non-idle state; real buffer-duration accounting | after the diagnostic build reports |
| **Janus** | The flag-off-capture option as a decision with a date on it, rather than a November discovery | xian's call; on the table as of rev 19 |
| **Pard** | Re-check the removal date in App Store Connect — three builds have now been accepted | a natural moment in the console |
| **Cairn** | Update Dan's brochure once a build survives use, and fix the AI writing tics he flagged | xian forwarding the feedback; a working build |
| **Janus** | Registry: two entries — `mediajunkie/optilisten` (app) and `Design-in-Product/optilisten` (live site) | memo 09-07; unconfirmed |

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
