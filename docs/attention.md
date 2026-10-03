# OptiListen — what needs xian

**Maintained by:** Cairn · **Updated:** 2026-10-03 (rev 49) · **Deadline:** 2026-11-24 — **52 days**, day 38 of 90

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
to xian@pobox.com was re-read 10-03: nothing about removal; newest OptiListen mail is the 2.0 (7)
processing pair of 10-02 19:01 PT. A TestFlight build is not a submission, so the date has not moved;
nothing confirms it either.

---

## Needs you

| # | Item | Why it's yours | Cost |
|---|---|---|---|
| 1 | **Run 2.0 (7) twice: once with a second person talking in the room, once outdoors.** It is in TestFlight now — update from (5) on your phone. | Only a phone in a real room can test it. The second speaker is the one test that stresses D-021 ("other" needs a 0.3 s run before it counts). Outdoors has never been tried under the 12 dB bar: 09-26 (14.8 dB) was indoors, and the 09-20 outdoor session measured 9.7 dB, which this build would refuse to score. Tell me what each run showed. | 2 × ~10 min |
| 2 | **Read and sign off the 2.0 listing copy — or redirect it.** Five fields in [`docs/store-content-2.0.md`](store-content-2.0.md): **subtitle** and **description** (§1), **promotional text** (§1), **What's New** (§2.2), **notes to the reviewer** (§2.3). The six screenshots are in [`docs/store-art/6.9-inch/`](store-art/6.9-inch). | Every one is published under your name, behind xian@pobox.com. The current description's first sentence ("Put your headphones on…") has to go either way. Skip the file's Findings 2 and 3 and its privacy-URL warning — all three are settled. | 15 min |

Nothing else on this board is waiting on you.

## In flight

| Owner | Item | Waiting on |
|---|---|---|
| **Pard** | Prep and hold the flag-off-capture fallback build | xian's 09-17 re-rank, item 6. Whether it ships is xian's call; nothing is asking for it yet |
| **Cairn** | Read the 2.0 (7) field results and decide whether (7) is the submission candidate | xian's two runs (Needs you #1) |
| **Cairn** | `calibration: Calibration?`, delete `.unavailable`, make "I don't know" representable; persist calibration | held deliberately out of shipped builds — it changes classification, and an observing build shouldn't change what it observes |
| **Cairn** | Lifecycle state machine, one engine owner, `stop()` reachable from every non-idle state; real buffer-duration accounting | queued behind the build lane |
| **Cairn** | Update Dan's brochure once a build survives use | a build that has been used |
| **Janus** | Registry: two entries — `mediajunkie/optilisten` (app) and `Design-in-Product/optilisten` (live site) | memo 09-07; still unconfirmed |
| **xian, at submission** | Uncheck **Mac** and **Apple Vision** availability in App Store Connect | decided 10-02 (D-014): 2.0 does not claim either. The setting is behind xian@pobox.com, so it is one click when the 2.0 version record is created |
| **held** | Site Tier 3 — visual refresh toward moss/amber, FAQ tone, structure | a 2.0 submission date, by the same don't-shoot-twice logic as the screenshots. Ready checklist in `docs/site-audit-2026-09-27.md` |

## Closed since rev 40

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

- **2.0 (7) has compiled and uploaded, and has not been run.** D-021 changes what counts as the other
  person speaking, and no one has yet used it in a conversation.
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

*rev 49 · 2026-10-03 08:1x PT · Cairn · 2.0 (7) is in TestFlight; the field test moves to Needs you*
