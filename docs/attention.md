# OptiListen — what needs xian

**Maintained by:** Cairn · **Updated:** 2026-09-17 (rev 22) · **Deadline:** 2026-11-24 (68 days · day 22 of 90 — still carried from the 08-26 notice; nobody has read it back from App Store Connect)

Canonical state. Janus may summarize this into the cross-project meta-rollup.
Rendered for xian as an artifact — https://claude.ai/code/artifact/54087bd3-f172-494f-b79b-49d3406f5215
(republish that same URL rather than creating a new one). This file is the source; the artifact follows it.
The artifact's HTML source lives beside this file at `docs/attention.html`.

> **rev 22 — the correction is mine: the removal clock has not moved, and it does not count**
> **TestFlight builds. Apple's published wording is "until you submit an update and it's approved."**
>
> This rollup has carried since rev 19 the line *"three accepted builds may well have moved it."*
> **I wrote that, and it is wrong.** Verified this pass against Apple's own App Store Improvements
> page: *"You'll be asked to submit an update within 90 days to keep your app on the App Store. If
> you're unable to make the changes within this time frame, your app will be removed from the App
> Store until you submit an update and it's approved."* **An upload to App Store Connect is not a
> submission; a TestFlight build is not an update.** Four builds have cleared *processing* — a
> notarization and format check. Zero have entered App Review. One Job's mail this week shows what
> the other thing looks like: *Ready For Review → Waiting for Review → In Review → Pending Developer
> Release → Ready for Distribution*, four days, none of which OptiListen has produced.
>
> **This is not an emergency and is deliberately not dressed as one.** 68 days is real runway for a
> submission whose only hard dependency is a build that doesn't crash. But the number was measuring
> the wrong event, and it made the flag-off-capture option look less urgent than it is — that
> option's whole argument is *certainty against 24 November*, and the date is 68 days out rather
> than partly bought down. Pard's console readback now has two questions, not one: the date, **and**
> whether any version shows a review state.
>
> **2.0 (4) is not just uploaded — it is on his phone.** Apple's processing mail landed
> 2026-09-17 00:12:45 UTC, ~73 seconds after Pard's memo, and TestFlight says *available to test*.
> Pard's `buffersReceived 0 → 2` check, controlled against the preserved 2.0 (3) IPA, is the first
> binary check this month that earned the word verified. **The diagnostic surface is provably in the
> bits xian is holding.**

> **rev 21: the diagnostic build is written, pushed and handed to Pard — and there is no crash**
> **artifact for 2.0 (3), which is the same defect one layer out.**
>
> **Pard checked twice, three hours apart: the crash feed has not moved.** Newest submission is
> 09-15 and its `Version:` field reads 2.0 (2). **There is no 2.0 (3) artifact of any kind** — most
> likely because a TestFlight crash submission only exists if the tester taps *Share* on a modal,
> and this time he didn't or it didn't appear. His report stands as evidence; the artifact simply
> isn't there. **Pard's standing check returned "nothing new," which was true and useless**, and he
> had said on 09-14 that a quiet feed would be evidence the fix held. That inference is dead.
>
> **Note the shape.** The app dies or does nothing and tells no one why — and our instrument for
> watching it does the same. Both fail toward reassurance: a check that says "nothing new" when it
> cannot see, and a view that renders a calm `0%` when nothing arrived. **Rule adopted: an
> instrument that cannot distinguish "nothing happened" from "I could not see" is not a check, and
> its quiet reading may not be reported as a result.**
>
> **So the diagnostic build shipped in the same fire that learned this** — `62feb22`, **2.0 (4)**,
> with Pard's ask as its spine: the failure renders on screen, and the log copies with one tap, so
> nothing depends on catching a modal. My own row had read "waiting on the crash log"; there is no
> crash log, so that row would have waited forever. **The worst thing found while writing it:**
> `CalibrationView` substituted `-20` and `-50` for two failed readings — which *is*
> `Calibration.unavailable`, whose 30 dB gap passes `isUsable` — so a calibration in which **both
> readings failed** drew a green checkmark and the word "Ready." Not silence: the opposite of the
> truth, asserted confidently.
---

## Needs you

| # | Item | Why it's yours | Cost | Blocking |
|---|---|---|---|---|
| 1 | **Run 2.0 (4) — it is in your TestFlight now.** Install it, start a practice session, let it sit ten seconds, end it, then tap the stethoscope and paste the log. | **This is the only step nobody else can do, and it is no longer waiting on anyone.** Apple finished processing at 17:12 PT yesterday. The build exists to make the app say what happened to it, and it says it to whoever is holding the phone. Three builds have been diagnosed by reading source; this is the first that can be diagnosed by reading the app. Pard's binary check confirms the diagnostic strings are in the shipped bits, so if it renders nothing that is itself a finding. | ~3 min | every remaining capture bug — and, behind it, the submission |
| — | Previously here, still true: **nothing else.** Dan's feedback arrived and is applied; Pard has the crash log fetch; the next build is a diagnostic build. | One thing to overrule if you want to: the brochure's footer now reads "drafted by Claude for Christian," and every first-person claim that wasn't your own action or decision is gone. Dan's markup flagged that as its most serious item. Change the byline if you'd rather handle the disclosure differently. | — | — |

## Dan's answer

**Good doc, good plan, and he volunteered to test the app** ("happy to try for the practice app if
it's not too much of a hassle"). He also ran his own `no-ai-tropes` skill over the brochure twice and
sent back **83 comments, 90 deletions, 20 em dashes, on about 1,400 words**, with the note that he
gets "itchy" reading AI-speak. The content was fine. The prose nearly stopped him reading it.

**Ten of the 83 are not about phrasing.** The document was agent-written, in the first person, signed
with your name, containing claims about what you had done and thought that you had neither done nor
said. That is the same failure as this month's others, one layer out: reporting our own output as a
reading of the world. Written up as `mediajunkie/docs/convention-plain-language.md` and sent to
Themis for the shared methodology, per your instruction.

Brochure republished as v2 with every edit applied. Dan's skill and the full markup archived at
`docs/reference/`.

## A live strategic option, not yet a recommendation

**Live capture is not required for App Store compliance and is not required for the product
argument.** The loop closes on intention + reflection, `ManualSource` exists, and
`Practice.isComplete` ignores measurement by design. So there is a shippable build with the
microphone behind a flag and the manual number as the only path: Apple satisfied, capture off the
critical path. It trades a working prototype in Dan's hands for certainty against 24 November.
**68 days and three failed builds is the reason it's on the table now rather than discovered in
November.**

## Resolved this pass

- **2.0 (4) shipped, processed, and is testable** — delivery `d3c30721`, Apple's processing mail
  2026-09-17 00:12:45 UTC, TestFlight *available to test*. **Pard's binary check discriminates this
  time and he proved it against a control** before believing it: `buffersReceived` 0→2, `sample
  input format` 0→1, `tap installed` 0→1 against the preserved 2.0 (3) IPA. Artifact clean:
  `CFBundleVersion = 4`, mic string, launch screen, correct signing.
- **`62feb22` did not compile, and Pard repaired it rather than round-trip** — `9d2fd19`. My
  `@Sendable` on `sampleLevel`'s tap made the compiler strict about the capture: `AVAudioPCMBuffer`
  is not `Sendable`, so building the `Double` inside the `Task` became "passing closure as a
  'sending' parameter." He applied the shape `start()`'s tap twenty lines up already uses — compute
  the level first, send that across — marked it at the site with his name, the date and "compile fix
  only," and led his memo with it. **Authority confirmed this pass: he keeps it.** The line: if the
  fix is the file's own existing pattern applied to the same problem, take it; if there are two
  reasonable shapes, or behaviour changes, stop at the error message. **My change was incomplete,
  not misapplied** — `swiftc -parse` on kindbook has no SDK and does no isolation analysis, which is
  the second cycle this month lost to the gap between syntax-checked and compiled.
- **The removal clock was re-derived from Apple rather than from us** — see rev 22 above. Correcting
  my own line, in the rollup that carried it.
- **The Apple mail channel is now a real instrument.** The pobox→Gmail forward carries App Store
  Connect mail, not just receipts: the full processing chain for 2.0 (1)–(4) and One Job's entire
  1.1 review are readable. **What is still absent is any removal or App Store Improvement mail at
  all** — the 08-26 notice predates the forward, so its absence is expected and proves nothing.

- **The diagnostic build is written and pushed** — `62feb22`, 2.0 (4). `CaptureState.failed(String)`
  set before every throw so the reason survives a caller that swallows; `buffersReceived` separates
  an engine receiving nothing from one that never started; `isCalibrated` says when a number is
  computed against placeholder thresholds; a rolling event log copyable from the listening screen,
  a stethoscope toolbar button, and a failed-calibration screen. `stop()` is now reachable from
  every state (it guarded on `isRunning`, set last in `start()`, so a failed start could never be
  torn down) and the interruption-observer token is held and removed.
  **Syntax-checked only** — `swiftc -parse` clean on kindbook, which has no SDK, so no type
  checking and no isolation analysis. Not compiled.
- **The ask about the 2.0 (3) crash submission is answered: there isn't one.** Pard ran it twice
  and re-pulled the logbody to rule out a cached list. Newest is 09-15 against 2.0 (2).
- **One positive result survives from xian's report:** 2.0 (3) did *not* crash immediately the way
  (2) did. That is the only evidence anyone has that the `@Sendable` fix did anything, and no
  fourth theory has been built on it.

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
| **Cairn** | `calibration: Calibration?` and delete `.unavailable`; make "I don't know" representable | **deliberately held out of 2.0 (4)** — it changes classification, and an observing build should not change what it observes. `isCalibrated` makes it visible meanwhile |
| **Themis** | Carry the first-person convention to Janus as a Tier-2 candidate, in **his** framing of the recurrence, not mine | his call, taken 09-16 |
| **Cairn** | Lifecycle state machine, one engine owner, `stop()` reachable from every non-idle state; real buffer-duration accounting | after the diagnostic build reports |
| **Janus** | The flag-off-capture option as a decision with a date on it, rather than a November discovery | xian's call; on the table as of rev 19 |
| **Pard** | **Read back two things from App Store Connect, not one: the removal date, and whether any version of OptiListen shows a review state.** My clock correction comes from the wording Apple publishes, not from the console; the console is the instrument that confirms it against this app record. If the date has moved, I am wrong about the mechanism and want to know. | amended 09-17; nothing blocking |
| **Cairn** | Update Dan's brochure once a build survives use, and fix the AI writing tics he flagged | xian forwarding the feedback; a working build |
| **Janus** | Registry: two entries — `mediajunkie/optilisten` (app) and `Design-in-Product/optilisten` (live site) | memo 09-07; unconfirmed |

## Standing risks

- **Two builds shipped against two theories before anything was diagnosed; build 3 is the first that ships against a stack.** Both earlier theories were real defects; neither was the one. **The risk is not retired until a phone runs build 3** — a trace names a cause, and a cause is not yet a cure. The pattern to break is reasoning from source to a mechanism we can *see*, when the reporter has already named a mechanism we'd have to go look for. Pard's own rule, adopted here: **when a report names two things and you can only explain one, the one you can't explain is the finding.**
- **No instrumentation — half-retired as of 2.0 (4).** The app can now say what happened to it, on screen and in a copyable log. What is still missing is the outer half: there is no alert when a submission lands, and **a crash that produces no submission is invisible to Pard's standing check** — which is exactly what 2.0 (3) did. xian raised this on 09-14.
- **Compiling is not running, and running is not being used.** 2.0 has been launched on a real phone twice and died both times. Nobody has yet watched calibration, the mic tap, or the loop behave in an actual conversation.
- **Calibration is `Codable` and nothing persists it** — recalibrates every cold launch.
- **The fleet has one signing path and it expires Aug 2027.** The API can renew it; nothing watches for expiry.
- **The 24 Nov date is still the screenshot, not an ASC readback — and the hopeful half of this line is now disproved.** Accepted builds do not move it: Apple stops the removal on *"an update and it's approved,"* which means App Review, not processing. Nobody has read the date back.
- **Apple has rejected this app once before** (July 2023, background modes). 2.0 omits `UIBackgroundModes` — which is also, possibly, the thing making it crash. If the fix needs an audio background mode, that is a submission-risk conversation, not just a code change.
- **Age-rating social-media questions** at submission; ~10 min; answers are "no."
- **A claim in this rollup is not a commit.** Rev 17 marked the isolation fix as mine and owned; the fix then sat unwritten for 58 hours while the row read — to Pard, to Janus, and to the next instance of me — exactly like work in progress. Ownership recorded here now has to be followed in the same fire by either the work or a stated hand-off.
