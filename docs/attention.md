# OptiListen — what needs xian

**Maintained by:** Cairn · **Updated:** 2026-10-05 (rev 52) · **Deadline:** 2026-11-24 — **50 days**, day 40 of 90

Canonical state, kept lean on xian's instruction (2026-09-27, relayed by Janus): current active items
only, narrative to the logs, nothing cut that isn't stored elsewhere first.

- **History through rev 40** — every rev narrative, Dan's feedback, the resolved items and the retired
  risks — is archived verbatim at [`docs/attention-archive-through-rev40.md`](attention-archive-through-rev40.md).
- **The rev-40 page as rendered** is kept at `docs/attention-archive-through-rev40.html` — worth
  knowing it exists because it carried a **Method notes** section (13 condensed lessons from the month)
  that the markdown never had.
- **Decisions** D-001…D-022: [`docs/decisions.md`](decisions.md). **Session logs:** `logs/`.
- Rendered for xian as an artifact — https://claude.ai/code/artifact/54087bd3-f172-494f-b79b-49d3406f5215
  (republish that same URL rather than creating a new one). This file is the source; the artifact follows it.
  The artifact's HTML source lives beside this file at `docs/attention.html`.

**Deadline provenance, unchanged:** 24 November exists only in the 08-26 App Store Improvement Notice.
App Store Connect's API has no removal-date field, so it cannot be read back that way, and as of the
09-21 API read **no 2.0 version record exists at all** — App Review has never been entered. Apple's mail
to xian@pobox.com was re-read 10-05: nothing about removal; newest OptiListen mail is the 2.0 (7)
processing pair of 10-02 19:01 PT. A TestFlight build is not a submission, so the date has not moved;
nothing confirms it either.

---

## Needs you

**🔒 = blocked on xian**: work stops until he answers (his rule of 10-03, relayed by Janus).

| # | Item | Why it's yours | Cost |
|---|---|---|---|
| 1 | **🔒 blocked on xian since 10-04 — What did Dan say?** You answered the last question on 10-04: 2.0 (7) is not the submission build, Dan has tested and has feedback, more adjustments are likely. The next build cannot be scoped until that feedback is written down here. **Smallest answer:** paste or forward Dan's notes as he gave them, rough is fine, plus which build he ran — (5) or (7). | You hold it. A search of the forwarded mailbox on 10-04 and again on 10-05 (OptiListen, TestFlight, Brodnitz, last 6 days) found nothing from Dan about OptiListen, so it did not arrive anywhere an agent can read. | 5 min |

**The listing copy is no longer waiting on you.** It describes the app's behaviour closely (the single
number, green and amber, the one tap, the 1–5 rating), so adjustments after Dan's feedback may change
it. Answer it after the next build is settled, not now. It moved to In flight.

## In flight

| Owner | Item | Waiting on |
|---|---|---|
| **Pard** | Prep and hold the flag-off-capture fallback build | xian's 09-17 re-rank, item 6. Whether it ships is xian's call; nothing is asking for it yet |
| **Cairn** | Turn Dan's feedback into a scoped change list for the next build, and hand it to Pard | Dan's feedback (Needs you #1) |
| **held** | Listing copy sign-off — five fields in [`docs/store-content-2.0.md`](store-content-2.0.md), six screenshots in [`docs/store-art/6.9-inch/`](store-art/6.9-inch). xian's, 15 min, when it comes back | the next build being settled; the copy and the shots are rechecked against it first. The current description's first sentence ("Put your headphones on…") goes either way |
| **Cairn** | `calibration: Calibration?`, delete `.unavailable`, make "I don't know" representable; persist calibration | held deliberately out of shipped builds — it changes classification, and an observing build shouldn't change what it observes |
| **Cairn** | Lifecycle state machine, one engine owner, `stop()` reachable from every non-idle state; real buffer-duration accounting | queued behind the build lane |
| **Cairn** | Update Dan's brochure once a build survives use | a build that has been used |
| **Janus** | Registry: two entries — `mediajunkie/optilisten` (app) and `Design-in-Product/optilisten` (live site) | memo 09-07; still unconfirmed |
| **xian, at submission** | Uncheck **Mac** and **Apple Vision** availability in App Store Connect | decided 10-02 (D-014): 2.0 does not claim either. The setting is behind xian@pobox.com, so it is one click when the 2.0 version record is created |
| **held** | Site Tier 3 — visual refresh toward moss/amber, FAQ tone, structure | a 2.0 submission date, by the same don't-shoot-twice logic as the screenshots. Ready checklist in `docs/site-audit-2026-09-27.md` |

## Closed since rev 40

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

## Standing risks

- **What Dan tested is not recorded.** Neither the build he ran nor what he found has reached this repo,
  so it is not known whether D-021 (the 0.3 s rule for the other speaker, new in (7)) has been used in a
  conversation, or whether outdoors has been tried under the 12 dB bar.
- **50 days, and the next build is unscoped.** Each round is feedback, change, build, test; Apple's
  review comes after the last one.
- **Nothing watches for a submission landing.** A crash that produces no submission is invisible to
  Pard's standing check — which is exactly what 2.0 (3) did. Raised by xian 09-14, still true.
- **Calibration is `Codable` and nothing persists it** — recalibrates every cold launch.
- **The fleet has one signing path and it expires Aug 2027.** The API can renew it; nothing watches
  for expiry, and nothing tracks whether the API key itself is still valid (Pard, 10-02).
- **Apple rejected this app once before** (July 2023, background modes). 2.0 omits `UIBackgroundModes`.
  If a fix ever needs an audio background mode, that's a submission-risk conversation, not a code change.
- **Age-rating social-media questions** at submission; ~10 min; the answers are "no."
- **A claim in this rollup is not a commit.** Rev 17 marked a fix as owned and it then sat unwritten for
  58 hours while the row read like work in progress. Ownership recorded here is followed in the same
  fire by either the work or a stated hand-off.

---

*rev 52 · 2026-10-05 08:1x PT · Cairn · clocks only: mailbox quiet, no new Apple mail; the one open item is still Dan's feedback*
