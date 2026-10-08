# OptiListen — what needs xian

**Maintained by:** Cairn · **Updated:** 2026-10-08 08:2x PT (**rev 58**) · **Deadline:** 2026-11-24 — **47 days**, day 43 of 90

Rendered for xian at https://claude.ai/code/artifact/54087bd3-f172-494f-b79b-49d3406f5215 (same URL
every rev). This file is the source; the page follows it.

## Where things stand

- **Build 9 is in TestFlight**, on your phone and Dan's since 10-07 17:23 PT. It has the percentage
  as your talking out of the whole time (D-024). Pard's seat did not hold this upload. No run of it
  is recorded yet.
- **Build 9 probably crashes if you tap Skip, or swipe the sheet down, while calibration is taking a
  reading.** This comes from reading the source, not from a phone: the reading keeps its hold on the
  microphone and the listening screen then asks for it a second time. Build 8 has the same path.
  Letting calibration finish avoids it.
- **The fix is on `main` as D-025** ([`docs/decisions.md`](decisions.md), commit `86f32a5`, build
  number 10). It compiles ([CI run 37798916638](https://github.com/mediajunkie/optilisten/actions/runs/37798916638)
  is green: Debug, iOS Simulator). It has not run on a device, and Pard has not built it.
- **Nothing has been submitted to Apple**, so 24 November has not moved.

## Needs you

Two items, about 7 minutes, neither blocking.

**1. Run build 9, and tell Dan it is the one.** TestFlight on your phone, update to 2.0 (9). Tap +,
then Start. Let calibration take both readings without touching Skip. Then talk on your own: the
number should rise while you talk and fall when you stop. One line back, what it did. Dan was told to
wait for this build; the one thing he needs to know is to let calibration finish.
Optional, one more minute, and it would turn my reading into a fact: quit the app, start again, and
tap Skip while it says "Talk normally". I expect a crash. If it does not crash, I am wrong about
build 9 and want to know.

**2. Three small edits to this scheduled task's prompt.** A scheduled run cannot edit its own
prompt, so they wait on you. Say "update the task prompt" in a Cairn session, or edit it in
Claude → Scheduled → "OptiListen — check agent mail and update the attention rollup". The edits,
ready to paste, are in [`docs/cairn-scheduled-task.md`](cairn-scheduled-task.md): the memory file
path, a pointer to your duty-cycle baseline, and the "no new mail" paragraph. Until then all three
live in my memory file, which each run reads first, and this run followed the baseline.

## In flight

| Owner | Item | Waiting on |
|---|---|---|
| **Pard** | Build 2.0 (10) from `main` and upload it | his queue; memo sent 10-08 |
| **Pard** | Re-shoot the store screenshots that show the changed captions (scripted, D-016). Asked 10-07; `docs/store-art` was last changed 09-24 | his queue; asked again 10-08 |
| **xian + Dan** | Once with a second person, once outdoors, on (9) or (10) | a first solo run (Needs-you 1) |
| **Cairn** | Revisit the ceiling slider's range and 30% default, which were chosen for a share of speech | a run of (9): real whole-time numbers |
| **Cairn** | Decide whether a calibration should expire inside a launch that stays open for days | someone having used the 12-second step on a phone |
| **held** | Listing copy sign-off — five fields in [`docs/store-content-2.0.md`](store-content-2.0.md), six screenshots in [`docs/store-art/6.9-inch/`](store-art/6.9-inch). xian's, 15 min, when it comes back | the submission build being settled; Dan also wants a language pass, "later" |
| **Cairn** | Update Dan's brochure once a build survives use | a build that has been used |
| **Pard** | Prep and hold the fallback build with live capture switched off | whether it ships is xian's call; nothing is asking for it |
| **Janus** | Registry: `mediajunkie/optilisten` (app) and `Design-in-Product/optilisten` (live site) | memo 09-07; unconfirmed |
| **xian, at submission** | Uncheck **Mac** and **Apple Vision** in App Store Connect → OptiListen → Pricing and Availability | the 2.0 version record existing |
| **held** | Site visual refresh (checklist in [`docs/site-audit-2026-09-27.md`](site-audit-2026-09-27.md)) | a submission date |

## Recorded, final

- 2.0 (7) is not the submission build (xian, 10-04).
- 2.0 does not claim Mac or Apple Vision (D-014, xian, 10-02).
- Keywords and categories stay as they are (xian, 10-02).
- The first conversation passes through calibration (D-023; xian agreed the flow should steer, 10-06).
- The percentage is your talking out of the whole time (D-024, xian, 10-07).

Older closed items: [`docs/attention-changelog.md`](attention-changelog.md). Decisions:
[`docs/decisions.md`](decisions.md). Narrative: `logs/`.

## Standing risks

- **Builds 8 and 9 likely crash on Skip during a calibration reading** (D-025). Inferred from the
  source; fixed on `main`; the fix is unbuilt.
- **D-023 and D-024 are in TestFlight in build 9 and no run of either is recorded** (Needs-you 1).
  Under D-024 a long quiet stretch lowers your number, and a ceiling of 30% is a looser limit than
  it was.
- **D-025 has been compiled, never run.** It changes how the microphone is handed between
  calibration and listening.
- **No run with a real second speaker exists on any build**, and none outdoors under the 12 dB bar.
- **47 days.** Each round is change, build, test; Apple's review comes after the last one.
- **A calibration lasts for one launch.** The 12-second step recurs on each cold start, and in a
  launch that stays open for days it is never retaken.
- **Nothing watches for a crash that produces no TestFlight submission** (xian, 09-14).
- **The fleet has one signing path and it expires Aug 2027**; nothing watches for expiry (Pard, 10-02).
- **Apple rejected this app once before** (July 2023, background modes). 2.0 omits `UIBackgroundModes`.
- **Age-rating social-media questions** at submission; about 10 min; the answers are "no".

## Verified how (rev 58)

- **Build 9 in TestFlight:** Apple's "completed processing" and "available to test" mails for 2.0 (9),
  both 2026-10-08 00:23 UTC, read in the forwarded Gmail from kindbook. Delivery UUID from Pard's memo.
  App Store Connect itself was not read (no key on kindbook). Whether anyone has installed or run it
  is not visible from here.
- **The Skip defect:** read from `CalibrationView.swift`, `PracticeLoopView.swift` and
  `LiveMicSource.swift` at `b354768`, the commit Pard's memo says (9) was built from. Apple documents
  one tap per bus. Not reproduced: nobody has done it on a phone.
- **The fix:** written in this run's container against `origin/main` at `5d7639d`, applied on kindbook
  with `git apply`. All ten Swift files pass `xcrun swiftc -parse` on kindbook (syntax only). CI run
  37798916638 on `86f32a5` is green (Debug, iOS Simulator): a full compile, not a run.
- **The screenshots:** `git log -- docs/store-art` on kindbook; newest commit 09-24. Amber's working
  tree was not read.

---
*rev 58 · 2026-10-08 08:2x PT · Cairn · build 9 is in TestFlight; a likely crash on Skip mid-calibration is fixed on main (D-025, build 10)*
