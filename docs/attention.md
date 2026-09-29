# OptiListen — what needs xian

**Maintained by:** Cairn · **Updated:** 2026-09-29 (rev 43) · **Deadline:** 2026-11-24 — **56 days**, day 34 of 90

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
to xian@pobox.com was re-read 09-29: nothing about removal, newest OptiListen mail is still the 2.0 (5)
processing pair of 09-21. Nothing has moved; nothing confirms it either.

---

## Needs you

| # | Item | Why it's yours | Cost |
|---|---|---|---|
| 1 | **Which environment was the 09-26 run?** You tested 2.0 (5) ("test convo b5") and it produced a real reading: gap **14.8 dB**, clear of the 12 dB bar. The report doesn't say indoors or outdoors. | Your 09-20 outdoor session measured a **9.7 dB** gap — under this build's bar, that session would have produced no number at all. If 09-26 was indoors, the outdoor question is still open. If it was outdoors, the bar has been tested and held and this closes on your word alone. | 2 min |
| 2 | **Tell Dan it's already on his phone.** No setup needed. | He is in the internal **DinP** group, state **INSTALLED** — read out of App Store Connect on the 21st. Internal groups get every processed build automatically, so he has been able to open 2.0 (5) since 15:36 UTC on 09-21 without knowing it's there. He's traveling; this is one sentence whenever you reach him, not a task. | 1 min |
| 3 | **Three things in the 2.0 listing that can't be settled from here.** Draft is `docs/store-content-2.0.md`. | **(a)** Uncheck — or deliberately keep — **Mac and Apple Vision**. The live Compatibility block lists 1.1 on both; [INFERRED] that's a per-app availability setting 2.0 inherits. 2.0 is portrait-only, opens the mic on launch, and has run on one iPhone. **(b)** The **keyword field and secondary category** aren't public and must be read before being overwritten. **(c)** Sign off on the **subtitle and description**, or redirect them — the current description's first sentence has to go either way. | 15 min |

Nothing else on this board is waiting on you.

## In flight

| Owner | Item | Waiting on |
|---|---|---|
| **Pard** | Build and upload the next TestFlight candidate | 2.0 (6) and (7) are both proposed; neither is built. Newest processed build is still **(5)**, 09-21 — verified in Apple's mail 09-29, not inferred. Sequencing is his call; no urgency from here |
| **Pard** | Prep and hold the flag-off-capture fallback build | xian's 09-17 re-rank, item 6. Whether it ships is xian's call; nothing is asking for it yet |
| **Cairn** | Field-test 2.0 (7) **with a real second speaker in the room** | the only test that actually stresses D-021; needs the build. D-020 was a display change, so (6) needs no field test |
| **Cairn** | `calibration: Calibration?`, delete `.unavailable`, make "I don't know" representable; persist calibration | held deliberately out of shipped builds — it changes classification, and an observing build shouldn't change what it observes |
| **Cairn** | Lifecycle state machine, one engine owner, `stop()` reachable from every non-idle state; real buffer-duration accounting | queued behind the build lane |
| **Cairn** | Update Dan's brochure once a build survives use | a build that has been used |
| **Janus** | Registry: two entries — `mediajunkie/optilisten` (app) and `Design-in-Product/optilisten` (live site) | memo 09-07; still unconfirmed |
| **held** | Site Tier 3 — visual refresh toward moss/amber, FAQ tone, structure | a 2.0 submission date, by the same don't-shoot-twice logic as the screenshots. Ready checklist in `docs/site-audit-2026-09-27.md` |

## Closed since rev 40

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
  `92fc1e9`, `CURRENT_PROJECT_VERSION` → 7. Parse-checked on kindbook, not yet on a device.
- Earlier and fully archived: the colour ruling (green, 09-24), the iPad question (dropped, 09-23),
  the `screenshot-fixture` merge and CI going green on `main` (D-018/D-019, 09-24).

## Standing risks

- **Newest build in TestFlight is 2.0 (5), eight days old**, while the code has moved to 7. Two proposed
  builds are unbuilt.
- **Nothing watches for a submission landing.** A crash that produces no submission is invisible to
  Pard's standing check — which is exactly what 2.0 (3) did. Raised by xian 09-14, still true.
- **Calibration is `Codable` and nothing persists it** — recalibrates every cold launch.
- **The fleet has one signing path and it expires Aug 2027.** The API can renew it; nothing watches
  for expiry.
- **Apple rejected this app once before** (July 2023, background modes). 2.0 omits `UIBackgroundModes`.
  If a fix ever needs an audio background mode, that's a submission-risk conversation, not a code change.
- **Age-rating social-media questions** at submission; ~10 min; the answers are "no."
- **A claim in this rollup is not a commit.** Rev 17 marked a fix as owned and it then sat unwritten for
  58 hours while the row read like work in progress. Ownership recorded here is followed in the same
  fire by either the work or a stated hand-off.

---

*rev 43 · 2026-09-29 08:1x PT · Cairn · clocks only; mailbox quiet since Pard's 09-26 memo (answered)*
