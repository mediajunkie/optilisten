# OptiListen — what needs xian

**Maintained by:** Cairn · **Updated:** 2026-10-09 08:1x PT (**rev 60**) · **Deadline:** 2026-11-24 — **46 days**, day 44 of 90

Rendered for xian at https://claude.ai/code/artifact/54087bd3-f172-494f-b79b-49d3406f5215 (same URL
every rev). This file is the source; the page follows it.

## Where things stand

- **Build 10 is in TestFlight**, available since 10-08 16:16 PT. It has everything build 9 had (the
  percentage as your talking out of the whole time, D-024) plus the fix for the Skip crash (D-025).
  Pard's seat did not hold the upload. No run of it is recorded yet.
- **Skip builds 8 and 9.** Reading the source, both probably crash if you tap Skip, or swipe the
  sheet down, while calibration is taking a reading. Nobody reproduced it on a phone, and with (10)
  out there is no reason to.
- **The store screenshots are re-shot** from build 10's code and show the new captions ("of the time
  is you talking"). I looked at four of the six.
- **This task's prompt carries the four edits** you made on 10-08. Checked against the prompt this
  run was started with.
- **Nothing has been submitted to Apple**, so 24 November has not moved.

## Needs you

One item, about 5 minutes, not blocking.

**1. Run build 10, and tell Dan it is the one.** TestFlight on your phone, update to 2.0 (10). Tap +,
then Start. Let calibration take both readings. Then talk on your own: the number should rise while
you talk and fall when you stop. One line back, what it did. Dan was told to wait for the next
version; this is it, and he no longer needs a warning about Skip.
Optional, one more minute: quit the app, start again, and tap Skip while it says "Talk normally".
On (10) I expect no crash and a session that shows no number. D-025 has never run on a device, so
this is the first check of it.

## In flight

| Owner | Item | Waiting on |
|---|---|---|
| **xian + Dan** | Once with a second person, once outdoors, on (10) | a first solo run (Needs-you 1) |
| **Cairn** | Revisit the ceiling slider's range and 30% default, which were chosen for a share of speech | a run of (10): real whole-time numbers |
| **Cairn** | Decide whether a calibration should expire inside a launch that stays open for days | someone having used the 12-second step on a phone |
| **held** | Listing copy sign-off — five fields in [`docs/store-content-2.0.md`](store-content-2.0.md), six screenshots in [`docs/store-art/6.9-inch/`](store-art/6.9-inch). xian's, 15 min, when it comes back. The screenshots are current as of build 10 | the submission build being settled; Dan also wants a language pass, "later" |
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

- **D-023, D-024 and D-025 are in TestFlight in build 10 and no run of any of them is recorded**
  (Needs-you 1). D-025 changes how the microphone is handed between calibration and listening.
  Under D-024 a long quiet stretch lowers your number, and a ceiling of 30% is a looser limit than
  it was.
- **Builds 8 and 9 are still installable and likely crash on Skip during a calibration reading.**
  Inferred from the source. Updating to (10) removes it.
- **No run with a real second speaker exists on any build**, and none outdoors under the 12 dB bar.
- **46 days.** Each round is change, build, test; Apple's review comes after the last one.
- **A calibration lasts for one launch.** The 12-second step recurs on each cold start, and in a
  launch that stays open for days it is never retaken.
- **Nothing watches for a crash that produces no TestFlight submission** (xian, 09-14).
- **The fleet has one signing path and it expires Aug 2027**; nothing watches for expiry (Pard, 10-02).
- **Apple rejected this app once before** (July 2023, background modes). 2.0 omits `UIBackgroundModes`.
- **Age-rating social-media questions** at submission; about 10 min; the answers are "no".

## Verified how (rev 60)

- **Build 10 in TestFlight:** Apple's "completed processing" and "available to test" mails for
  OptiListen 2.0 (10), both 2026-10-08 23:16 UTC, read in the forwarded Gmail from kindbook at
  08:0x PT on 10-09. Delivery UUID and "built from `ebc5b45`" are from Pard's memo
  (`docs/mail/memo-pard-to-cairn-cc-janus-xian-2-0-10-uploaded-store-art-reshot-and-why-i-missed-both-asks-2026-10-08.md`);
  `project.yml` and the committed project both read 10 at `76ac25c`. App Store Connect itself was
  not read (no key on kindbook). Whether anyone has installed or run it is not visible from here.
- **The screenshots:** commit `a690217`. I opened shots 3, 4, 5 and 6 from that commit and read them:
  "22% of the time is you talking, ceiling 30%"; "41% of the time is you talking, over your 30%
  ceiling"; "24% of the time was you talking, you 6:00 · others 15:12 · quiet 3:48" (6:00 of 25:00
  is 24%, the whole-time figure); history rows labelled "you talking". All six are 1320×2868.
  Shots 1 and 2 were not opened.
- **The prompt edits:** compared the prompt this run received with the four edits in
  [`docs/cairn-scheduled-task.md`](cairn-scheduled-task.md). All four are present. That page now
  holds the 10-09 copy.
- **No other Apple mail, nothing from Dan:** the same Gmail search. Nothing about removal. Nothing to
  or from Dan in four days.
- **The Skip defect in 8 and 9** stands as at rev 58: read from the source at `b354768`, not
  reproduced. **The fix** stands as at rev 58: CI run 37798916638 on `86f32a5` is green (Debug, iOS
  Simulator), a compile and not a run; Pard reports the Release configuration also compiles.

---
*rev 60 · 2026-10-09 08:1x PT · Cairn · build 10 is in TestFlight with the Skip fix; screenshots re-shot; the prompt edits are in*
