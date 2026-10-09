# OptiListen attention rollup: changelog

Companion to [`attention.md`](attention.md). Items that are done or superseded leave the board and
land here, newest first, so the board holds only what is current (network convention of 2026-10-06,
`mediajunkie/designinproduct` → `docs/conventions/attention-rollups-and-living-docs.md`). Everything
through rev 40 is in [`attention-archive-through-rev40.md`](attention-archive-through-rev40.md).

## Removed at rev 60 (2026-10-09)

- **Needs-you #1, "Run build 9, and tell Dan it is the one."** Superseded: build 10 is in TestFlight
  and carries the Skip fix, so the run is asked of (10). Whether xian or Dan ran (9) is not recorded.
  The optional control (Skip on 9, expect a crash) is dropped with it; the reading of builds 8 and 9
  stays an inference.
- **Needs-you #2, "Four small edits to this scheduled task's prompt."** Done by xian by hand on 10-08
  about 17:30 PT (Janus's memo `76ac25c`; his own attempt through the API was abandoned because the
  task's configuration is about 100 KB). Confirmed on 10-09 against the prompt the 08:00 run received.
- **In flight, "Build 2.0 (10) from `main` and upload it" (Pard).** Done 10-08 16:1x PT from
  `ebc5b45`, delivery UUID `280119b2-2903-4961-be0a-ddce0fe69a17`. Apple's two mails are dated 10-08
  16:16 PT. His seat did not hold the upload. Why the 08:25 request sat eight hours: it landed ten
  minutes before the mail-wake baseline, which recorded it as already seen, and his own sweep windows
  left a gap over it. Fixed on his side (`mail-sweep.sh --since-last`).
- **In flight, "Re-shoot the store screenshots" (Pard).** Done at `a690217`; shots 2 to 6 changed.

## Removed at rev 58 (2026-10-08)

- **Needs-you #1, "Run build 8 once yourself."** Superseded: build 9 is in TestFlight and carries the
  same calibration path, so the run is asked of (9). Whether xian ran (8) is not recorded.
- **In flight, "Build 2.0 (9) from `main` and upload it" (Pard).** Done 10-07 17:2x PT from `b354768`,
  delivery UUID `90bd4765-5899-45e9-a15a-5af60570b221`
  (`docs/mail/memo-pard-to-cairn-cc-janus-xian-2-0-9-uploaded-2026-10-07.md`). Apple's processing
  and available-to-test mails are dated 10-07 17:23 PT. His seat did not hold the upload, so the 🔒
  that rev 57 said was coming never opened. The screenshot re-shoot asked for in the same memo is
  not done and stays on the board as its own row.
- **In flight, "Remove the placeholder calibration from the classifier" (Cairn).** Done in D-025
  (`86f32a5`): `calibration` is an `Optional` and `Calibration.unavailable` is deleted.
- **In flight, "Lifecycle state machine, one engine owner, `stop()` reachable from every non-idle
  state" (Cairn).** Done in D-025 as three guards, not a state machine: a reading in flight gives
  the engine back to `start()`, a reading refuses to begin while the microphone is in use, and a
  `start()` overtaken by a `stop()` does not switch the microphone on. D-025 says why it stops there.
- **In flight, "decide whether a calibration is remembered between launches" (Cairn).** Answered
  no: a calibration is a reading of one room and one phone position. What remains is narrower
  (whether it should expire inside a long launch) and has its own row.
- **Reviewer notes, `docs/store-content-2.0.md` §2.3.** The walkthrough skipped the calibration sheet
  that D-023 put in front of the first practice, and described a number "against placeholder
  thresholds" that has not been shown since build 8. Rewritten at rev 58. Also "practising" →
  "practicing" in two places, per D-012.

## Removed at rev 57 (2026-10-07)

- **Needs-you #1, "🔒 What is the percentage a share of?"** Blocked 10-07 11:0x PT, answered 10-07
  16:1x PT by xian in the Cairn session: "whole time. yes, both Dan and I intuitively expected this,
  as per the 1.0, 1.1 design." Written the same session as D-024. Never escalated.
- **In flight, "Write the denominator change as D-024" (Cairn).** Done.
- **In flight, "Decide what the app says on screen about two people in one room" (Cairn).** Withdrawn:
  under D-024 the other voice no longer moves the number, so there is nothing to explain on screen.
- **Where things stand, the three bullets on Dan's reading and the earlier division.** Now in D-024.

## Removed at rev 56 (2026-10-07)

- **Needs-you #1, "🔒 Approve the TestFlight upload of 2.0 (8)."** Blocked 10-06 16:3x PT, answered
  10-07 ~08:00 PT ("Go", relayed by Janus to Pard). Pard uploaded; Apple's processing and
  available-to-test mails are dated 10-07 08:59 PT. Delivery UUID
  `a4e5974a-6a4c-4bb1-9e47-fc3a17887f4b`
  (`docs/mail/memo-pard-to-cairn-cc-janus-xian-2-0-8-uploaded-2026-10-07.md`). Never escalated.
- **Needs-you #2, "Answer Dan's question about two voices, and tell him where calibration is."**
  Overtaken: xian and Dan talked on 10-07
  (`docs/mail/xian-via-janus-to-cairn-dan-feedback-on-the-percentage-math-2026-10-07.md`). Whether
  the paste-ready text was used is not recorded. Its factual content stands in D-023.
- **In flight, "Upload 2.0 (8) to TestFlight" (Pard).** Done.
- **Where things stand, "Dan ran build 7 and liked it" and "Build 8 exists and is not in
  TestFlight."** Superseded; Dan's build-7 words are in the 10-06 memo and D-023.
- **Standing risk wording, "D-023 has been compiled in Debug and Release, never run."** Now "in
  TestFlight in build 8 and no run of it is recorded".

## Removed at rev 55 (2026-10-07)

- **In flight, "Build and upload 2.0 (8)" (Pard).** The build half is done: `scripts/release.sh
  --no-upload` on Amber, 10-06 16:3x PT, IPA read back as 2.0 (8), Distribution-signed
  (`docs/mail/memo-pard-to-cairn-cc-janus-xian-2-0-8-built-and-verified-upload-awaits-xian-2026-10-06.md`).
  The row now reads "Upload 2.0 (8)" and waits on xian.
- **Where things stand, "That is fixed in the code, and not yet in a build."** Superseded: it is in
  build 8.
- **Standing risk wording, "D-023 has been syntax-checked and compiled, never run."** Now "compiled in
  Debug and Release, never run": Pard's archive closed the Release gap.
- **Needs-you count, "One item, about 3 minutes, not blocked."** Now two; the upload approval is new
  and blocking.

## Removed at rev 54 (2026-10-06)

- **Needs-you #1, "What did Dan say?"** Blocked on xian 10-04 16:2x PT, escalated to Janus 10-06 08:0x,
  answered 10-06 11:4x by Janus relaying xian's chat with Dan verbatim
  (`docs/mail/janus-to-cairn-cc-xian-dans-feedback-on-build-7-2026-10-06.md`). Dan ran 2.0 (7).
- **Standing risk, "What Dan tested is not recorded."** Withdrawn: it is recorded now.
- **Standing risk, "the next build is unscoped."** Withdrawn: scoped as D-023 and written.
- **In flight, "Turn Dan's feedback into a scoped change list and hand it to Pard."** Done as D-023.
- **The "Closed since rev 40" section**, moved here verbatim:

### Closed since rev 40 (as it stood at rev 53)

- **2.0 (7) is not the submission build (10-04, xian's word, relayed by Janus).** Dan has done initial
  testing and has feedback; more adjustments are expected. The two field runs asked for on 10-03 are
  withdrawn as a gate — they belong to whichever build comes next.
- **The blocked-on-xian rule is adopted (10-04).** Janus's memo of 10-03; both Needs-you items carry 🔒 and
  a date, and both went to Janus the same day.
- **2.0 (7) is in TestFlight (10-02 19:01 PT).** Pard built, exported and uploaded it from Amber; (6) was
  skipped. Apple's "completed processing" and "available to test" mails for 2.0 (7) are both in the
  forwarded mailbox, and Pard read the build back from App Store Connect as `VALID`. The release procedure
  is now a script with a gate per past mistake: `scripts/release.sh`, explained in
  [`docs/RELEASE.md`](RELEASE.md).
- **Closed 10-02 on xian's word:** Pard nudged for build (7); the 09-26 run was indoors; Dan knows 2.0 (5)
  is on his phone (he has been on family travel); Mac/Vision will not be claimed (**D-014**). **Keywords and
  categories stay as they are** — nothing requires changing them, and the proposed replacements are
  optional and kept in the draft.
- **The board itself.** xian's lean-board advice applied: 13 rev narratives (rev 27…40) and the
  resolved/retired history moved to the archive file linked above. 728 lines → this.
- **Site work is finished.** Tier 1 and Tier 2 shipped *and deployed live* (`5087264`, `c8b80fd`,
  `687b760`; deploy verified in the shipped bundle, not just on `main`). The Privacy page now explains
  the microphone, both stale 2022 dates are current, and `/privacy` stopped 404-ing on 09-24 — which
  **retires the listing item that used to be (c)**. The 1.x headphone wrinkle is recorded as **D-022**.
- **"Compiling is not running, and running is not being used" is retired.** 2.0 (5) ran in a real
  conversation on 09-26 and produced a usable measurement. That risk stood since rev 17.
- **The percentage report** — a display defect, not the math: **D-020**, fixed `86213d5`.
- **The second classification gap** — "other" now needs a 0.3s minimum run: **D-021**, fixed
  `92fc1e9`, `CURRENT_PROJECT_VERSION` → 7. Compiled and shipped in 2.0 (7); not yet run on a device.
- Earlier and fully archived: the colour ruling (green, 09-24), the iPad question (dropped, 09-23),
  the `screenshot-fixture` merge and CI going green on `main` (D-018/D-019, 09-24).
