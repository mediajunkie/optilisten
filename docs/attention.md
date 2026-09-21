# OptiListen — what needs xian

**Maintained by:** Cairn · **Updated:** 2026-09-21 (rev 28) · **Deadline:** 2026-11-24 (64 days · day 26 of 90 — from the 08-26 notice, the only place the date exists; App Store Connect's API has no removal-date field. No 2.0 version is in review)

Canonical state. Janus may summarize this into the cross-project meta-rollup.
Rendered for xian as an artifact — https://claude.ai/code/artifact/54087bd3-f172-494f-b79b-49d3406f5215
(republish that same URL rather than creating a new one). This file is the source; the artifact follows it.
The artifact's HTML source lives beside this file at `docs/attention.html`.

> **rev 28: the release candidate is written, unbuilt, and waiting on one word from you.**
> Pard read both of last night's memos in order, acted on the second only, and **built nothing from
> the superseded tree** — Amber was rebooting through that window (macOS 26.7, fleet resume), so
> there is nothing to discard. His stated condition for building: current `main`, same build number
> 5, the design pass included, `docs/design-pass-2026-09-21.md` read first. He is holding because he
> read the scheduling as yours — *"xian's call, not tonight"* — and that was 21:12 PT on the 20th.
>
> **Nothing else moved overnight.** No Apple mail about OptiListen since the 2.0 (4) processing
> notice of 2026-09-17 00:12 UTC: no review state, no new build, no removal or App Store Improvement
> mail. Four builds have cleared processing, zero have entered review, so 24 November stands where
> it stood. That channel is evidence about the clock and about nothing else — it cannot say whether
> a build has been run.
>
> **This file was the stale half this time, not the page.** The rendered rollup has said since last
> night that nothing is waiting on you; this file still carried "run 2.0 (4)" in Needs you, which you
> did on the 20th. The usual split runs the other way. Fixed here; the two are level again.

> **rev 27: 2.0 (5) is the release candidate, and it goes to Dan as well as to you.**
> Four field fixes plus a ratified six-item design pass, all on `main`, all parse-clean, Pard's to
> build. He had not started (5) when the design work landed, so it folds into the same build number.
>
> **The design reframe, recorded in `docs/design-pass-2026-09-21.md`: the app is not too plain, it
> is undesigned.** Every control sat where SwiftUI put it, in system blue, at default weight. Plain
> is the right answer for an instrument you set face-up and stop looking at, but it has to be a
> decision rather than an absence. Landed: one accent pair (moss inside your intention, amber over
> the ceiling, semantic rather than decorative) applied once at the app root; the End button off
> filled destructive red, which was the loudest element on a screen about listening quietly; the
> number settling on the existing one-second tick instead of redrawing every 100 ms; two haptics,
> at the first ceiling crossing and at the loop closing, because the phone is face-up and unwatched;
> the Home counter animating on change; and no "0" in 52-point type on first launch.
>
> **Not a detour from 24 November:** the listing needs new screenshots, and screenshots of an
> undesigned app are what a prospective user sees.
>
> **What the build is for, stated so the test is deliberate.** The calibration thresholds in it are
> mine, estimated from one field run: `isUsable` 8 dB → 12, silence floor `ambient - 6` →
> `ambient + 3`. Your 09-20 outdoor calibration measured a 9.7 dB gap, so **under this build that
> same session produces no number at all** and says your voice and the room are too close together.
> Intended, and the thing under test. One indoor run and one outdoor run answers it. If indoors also
> refuses, the bar is wrong and I would rather find that out in a day than defend it.

---

## Needs you

| # | Item | Why it's yours | Cost | Blocking |
|---|---|---|---|---|
| 1 | **Say go on building 2.0 (5).** One line to Pard — he builds from current `main`, build number 5, and uploads. | He has held since 21:12 PT on the 20th because he read the scheduling as yours, and he is right that it is. **Nothing technical is pending:** the four field fixes and the ratified design pass are both on `main`, both parse-clean, and he confirmed nothing was built from the superseded tree, so there is nothing to redo. The only cost of the wait is the wait. | ~1 min | the field test, Dan's first look, and the listing screenshots behind both |
| 2 | **Then run it twice — once indoors, once outdoors — and say whether it goes to Dan in the same pass.** | The calibration bar in this build is mine, estimated from your single 09-20 run: `isUsable` 8 dB → 12, floor `ambient - 6` → `ambient + 3`. **Your outdoor session would produce no number at all under it** — intended, and exactly the thing under test. One run each way settles whether the bar is right. Dan said yes on 09-16, has waited five days, and has never seen the app at all. | ~10 min | whether the thresholds hold, and Dan's first contact with the product |
| — | **Done, and previously item 1: you ran 2.0 (4)** on the 20th. The report was the most useful artifact of the month — four findings, all four fixed, and the diagnostics panel turned "it may have treated bird calls as talking" into `silence 0.0` over 100.8 seconds, which is a measurement rather than an impression. | One thing still open to overrule if you want to: the brochure's footer now reads "drafted by Claude for Christian," and every first-person claim that wasn't your own action or decision is gone. Dan's markup flagged that as its most serious item. Change the byline if you'd rather handle the disclosure differently. | — | — |

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
**65 days and three failed builds is the reason it's on the table now rather than discovered in
November.**

**Where it stands (rev 24):** you ranked it on 09-17, item 6: *"Let's prep the fallback build and have
it ready if we run short of time."* Pard preps and holds it. Whether it ships is your decision, and
nothing is asking you for it yet.

## Resolved this pass

- **Pard's hold is acknowledged and clean.** Both of last night's memos read in order, second
  superseding the first, **nothing built from the morning tree and nothing discarded** — Amber was
  rebooting through the window. Build conditions restated by him: current `main`, build number 5,
  design pass included, spec read first. Waiting on xian's scheduling, not on any work.
- **Apple mail re-read this pass and it is empty in the way that means nothing new** — newest
  OptiListen mail is still the 2.0 (4) processing notice, 2026-09-17 00:12 UTC. No review state, no
  removal or Improvement mail. The limit stands: that channel speaks to the clock and to nothing
  else.

- **Pard's App Store Connect readback is closed** (09-18 evening). Versions on the record: 1.1
  `READY_FOR_SALE`, 1.0 `REPLACED_WITH_NEW_VERSION`; **no 2.0 version exists in review**. The API has
  no removal-date field, so the 08-26 notice is the only source for 24 November.
- **Fallback build provenance confirmed**: xian's 09-17 re-rank, item 6, quoted verbatim by Pard.
  Prep and hold is Pard's; shipping is xian's call. Pard fixed `mediajunkie/docs/backlog.md` at
  source, which had carried neither.
- **Correction: the shipped 1.x is 1.1, not 1.3 (6).** Verified against the public App Store
  listing (1.1, 2023-07-19) and Pard's ASC table. 1.3.6 is the source repo's head, bumped
  2023-05-30. No effect on 2.0.
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
| **Pard** | Build and upload 2.0 (5) from current `main`, build number 5 | **xian's go.** Held since 21:12 PT 09-20; nothing was built from the superseded tree |
| **Pard** | Prep the flag-off-capture fallback build and hold it (xian's 09-17 re-rank, item 6) | after 2.0 (4) reports; shipping it is xian's call |
| **Cairn** | Update Dan's brochure once a build survives use, and fix the AI writing tics he flagged | xian forwarding the feedback; a working build |
| **Janus** | Registry: two entries — `mediajunkie/optilisten` (app) and `Design-in-Product/optilisten` (live site) | memo 09-07; unconfirmed |

## Standing risks

- **Two builds shipped against two theories before anything was diagnosed; build 3 is the first that ships against a stack.** Both earlier theories were real defects; neither was the one. **The risk is not retired until a phone runs build 3** — a trace names a cause, and a cause is not yet a cure. The pattern to break is reasoning from source to a mechanism we can *see*, when the reporter has already named a mechanism we'd have to go look for. Pard's own rule, adopted here: **when a report names two things and you can only explain one, the one you can't explain is the finding.**
- **No instrumentation — half-retired as of 2.0 (4).** The app can now say what happened to it, on screen and in a copyable log. What is still missing is the outer half: there is no alert when a submission lands, and **a crash that produces no submission is invisible to Pard's standing check** — which is exactly what 2.0 (3) did. xian raised this on 09-14.
- **Compiling is not running, and running is not being used.** 2.0 has been launched on a real phone twice and died both times. Nobody has yet watched calibration, the mic tap, or the loop behave in an actual conversation.
- **Calibration is `Codable` and nothing persists it** — recalibrates every cold launch.
- **The fleet has one signing path and it expires Aug 2027.** The API can renew it; nothing watches for expiry.
- **The 24 Nov date exists only in the 08-26 notice.** App Store Connect's API has no removal-date field (Pard, 09-18), so it cannot be read back that way. Accepted builds do not move it: Apple stops the removal on *"an update and it's approved,"* which means App Review. As of 09-18 no 2.0 version exists in review.
- **Apple has rejected this app once before** (July 2023, background modes). 2.0 omits `UIBackgroundModes` — which is also, possibly, the thing making it crash. If the fix needs an audio background mode, that is a submission-risk conversation, not just a code change.
- **Age-rating social-media questions** at submission; ~10 min; answers are "no."
- **A claim in this rollup is not a commit.** Rev 17 marked the isolation fix as mine and owned; the fix then sat unwritten for 58 hours while the row read — to Pard, to Janus, and to the next instance of me — exactly like work in progress. Ownership recorded here now has to be followed in the same fire by either the work or a stated hand-off.
