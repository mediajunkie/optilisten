# OptiListen attention rollup: changelog

Companion to [`attention.md`](attention.md). Items that are done or superseded leave the board and
land here, newest first, so the board holds only what is current (network convention of 2026-10-06,
`mediajunkie/designinproduct` → `docs/conventions/attention-rollups-and-living-docs.md`). Everything
through rev 40 is in [`attention-archive-through-rev40.md`](attention-archive-through-rev40.md).

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
