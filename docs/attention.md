# OptiListen — what needs xian

**Maintained by:** Cairn · **Updated:** 2026-10-06 16:2x PT (**rev 54**) · **Deadline:** 2026-11-24 — **49 days**, day 41 of 90

Rendered for xian at https://claude.ai/code/artifact/54087bd3-f172-494f-b79b-49d3406f5215 (same URL
every rev). This file is the source; the page follows it.

## Where things stand

- **Dan ran build 7 and liked it.** His words: "the basic design is really elegant", "keeping this this
  simple is really nice". The number did not work for him: talking alone into the phone, his percentage
  went down. He had not calibrated, because nothing in the app sent him there.
- **That is fixed in the code, and not yet in a build.** Tapping Start now opens the 12-second calibration
  first, and without a calibration the app shows no number at all instead of a wrong one. Commit
  [`d154f55`](https://github.com/mediajunkie/optilisten/commit/d154f55), decision D-023. It compiles: [CI run 37545093840](https://github.com/mediajunkie/optilisten/actions/runs/37545093840) is green (Debug, iOS Simulator). Nobody has run it on a phone.
- **Build 8 is Pard's to make** from that commit; he was told today.
- **Nothing has been submitted to Apple**, so 24 November has not moved.

## Needs you

One item, about 3 minutes, not blocked (work continues either way).

**1. Answer Dan's question about two voices, and tell him where calibration is.** He asked whether the
app can tell different voices apart with no headphones, and said he would retry in the morning. Where the
action happens: your chat with Dan. Text you can paste or reword; every statement in it is read from the
build-7 source except the one marked "probably":

> Calibration in the build you have is the slider icon at the top left of the home screen. It takes about
> twelve seconds; do it before you tap +. Without it the app was using made-up loudness levels, which is
> probably why your number fell while you were the only one talking. The next build walks you into it.
>
> On two voices: it can't tell voices apart. It tells near from far, by loudness. You are next to the
> phone; the other person is coming out of a laptop speaker, or sitting further away. Two people the same
> distance from the phone both count as you. With headphones on it hears only you, so it gives no number.
>
> If the number looks wrong again: while it's listening, tap the stethoscope at the top right, then Copy,
> and send me what it gives you.

What Dan sends back decides whether build 8 needs anything more than D-023. Forward it to Janus or paste
it in any Cairn session.

## In flight

| Owner | Item | Waiting on |
|---|---|---|
| **Pard** | Build and upload 2.0 (8) from `main` at `d154f55` or later, with `scripts/release.sh` on Amber | his queue; memo in his mailbox today. `project.yml` already reads 8 |
| **xian + Dan** | Run (8) once it is in TestFlight: once with a second person talking, once outdoors | build 8. These are the two runs carried over from (7) |
| **Cairn** | Decide what the app says on screen about two people in one room | Dan's retry and his reaction to the answer above |
| **held** | Listing copy sign-off — five fields in [`docs/store-content-2.0.md`](store-content-2.0.md), six screenshots in [`docs/store-art/6.9-inch/`](store-art/6.9-inch). xian's, 15 min, when it comes back | the submission build being settled; Dan also wants a language pass, "later" |
| **Cairn** | Remove the placeholder calibration from the classifier; decide whether a calibration is remembered between launches | after (8); D-023 already stops the placeholder reaching the screen |
| **Cairn** | Lifecycle state machine, one engine owner, `stop()` reachable from every non-idle state | queued behind the build lane |
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

Older closed items: [`docs/attention-changelog.md`](attention-changelog.md). Decisions:
[`docs/decisions.md`](decisions.md). Narrative: `logs/`.

## Standing risks

- **D-023 has been syntax-checked and compiled, never run.** The path it changes, a sheet opening from
  inside another sheet and then advancing the screen behind it, is the kind of thing that compiles and
  misbehaves.
- **No run with a real second speaker exists on any build**, and none outdoors under the 12 dB bar.
- **49 days.** Each round is change, build, test; Apple's review comes after the last one.
- **Calibration is not remembered between launches**, so the 12-second step recurs on each cold start.
- **Nothing watches for a crash that produces no TestFlight submission** (xian, 09-14).
- **The fleet has one signing path and it expires Aug 2027**; nothing watches for expiry (Pard, 10-02).
- **Apple rejected this app once before** (July 2023, background modes). 2.0 omits `UIBackgroundModes`.
- **Age-rating social-media questions** at submission; about 10 min; the answers are "no".

## Verified how (rev 54)

- **Mail:** `docs/mail/` in this repo, 2 of 2 new memos read in full (both Janus, 10-06). Pard's and
  Janus's mailboxes pulled and listed, not read in full.
- **Dan's feedback:** Janus's relay of xian's chat, taken as verbatim. No diagnostics log from Dan's run
  exists, so why his number fell is a mechanism that fits, read from the thresholds in the build-7
  source; it is not a measurement.
- **The fix:** read back from `origin/main` after the push. CI run 37545093840 green on `d154f55`: a Debug simulator build, so it proves the code compiles and nothing about the Release configuration Amber archives. No device, no simulator run.
- **Apple:** forwarded Gmail searched from kindbook for Apple-domain mail, last 5 days. Newest is a One
  Job TestFlight mail of 10-06 13:30 PT, so the forward is live; nothing about OptiListen since the 2.0 (7)
  pair of 10-02 19:01 PT; nothing about removal. App Store Connect itself was not read (its key is on
  Amber). 24 November still rests on the 08-26 notice alone.

---

*rev 54 · 2026-10-06 16:2x PT · Cairn · Dan's feedback arrived; D-023 written and pushed; board rewritten to the 10-06 network conventions*
