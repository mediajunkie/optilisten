# OptiListen — what needs xian

**Maintained by:** Cairn · **Updated:** 2026-10-07 08:1x PT (**rev 55**) · **Deadline:** 2026-11-24 — **48 days**, day 42 of 90

Rendered for xian at https://claude.ai/code/artifact/54087bd3-f172-494f-b79b-49d3406f5215 (same URL
every rev). This file is the source; the page follows it.

## Where things stand

- **Dan ran build 7 and liked it.** His words: "the basic design is really elegant", "keeping this this
  simple is really nice". The number did not work for him: talking alone into the phone, his percentage
  went down. He had not calibrated, because nothing in the app sent him there.
- **That is fixed, and the fix is in a build that has not left Amber.** Tapping Start now opens the 12-second calibration
  first, and without a calibration the app shows no number at all instead of a wrong one. Commit
  [`d154f55`](https://github.com/mediajunkie/optilisten/commit/d154f55), decision D-023. It compiles: [CI run 37545093840](https://github.com/mediajunkie/optilisten/actions/runs/37545093840) is green (Debug, iOS Simulator).
- **Build 8 exists and is not in TestFlight.** Pard built it on Amber on 10-06 at 17:0x PT and read it back
  from the IPA: `com.longskymedia.optilisten`, 2.0 (8), Distribution-signed. The Release configuration
  compiles. His seat refused the upload as a production deploy and he did not route around it, so it waits
  on you (item 1). Nobody has run this build, on a phone or in a simulator.
- **Nothing has been submitted to Apple**, so 24 November has not moved.

## Needs you

Two items, about 4 minutes. The first is blocking: build 8 cannot reach you or Dan without it.

**1. 🔒 Approve the TestFlight upload of 2.0 (8).** Blocked since 10-06 17:0x PT. Where the action
happens: Pard's console on Amber, where it is his open item 2. The smallest answer is "go", then allow the
prompt. Or run it yourself on Amber: `cd ~/Development/optilisten && scripts/release.sh` (a rebuild and
upload, about a minute). Apple's processing mail follows in roughly ten minutes, and the build then
appears in TestFlight for you and Dan with no further step.

**2. Answer Dan's question about two voices, and tell him where calibration is.** He asked whether the
app can tell different voices apart with no headphones, and said he would retry on the morning of 10-07.
Not blocking. Whether you have already answered him is not visible from here. Where the
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
| **Pard** | Upload 2.0 (8) to TestFlight. Built and verified 10-06; the IPA is at `build/release-8-export/OptiListen.ipa` on Amber | your approval, Needs-you 1 |
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

- **D-023 has been compiled in Debug and Release, never run.** The path it changes, a sheet opening from
  inside another sheet and then advancing the screen behind it, is the kind of thing that compiles and
  misbehaves.
- **No run with a real second speaker exists on any build**, and none outdoors under the 12 dB bar.
- **48 days.** Each round is change, build, test; Apple's review comes after the last one.
- **Calibration is not remembered between launches**, so the 12-second step recurs on each cold start.
- **Nothing watches for a crash that produces no TestFlight submission** (xian, 09-14).
- **The fleet has one signing path and it expires Aug 2027**; nothing watches for expiry (Pard, 10-02).
- **Apple rejected this app once before** (July 2023, background modes). 2.0 omits `UIBackgroundModes`.
- **Age-rating social-media questions** at submission; about 10 min; the answers are "no".

## Verified how (rev 55)

- **Mail:** `docs/mail/` in this repo, 1 of 1 new memo read in full (Pard, 10-06 17:0x PT). It asks
  nothing, so no reply was sent. Pard's and Janus's mailboxes pulled and listed.
- **Build 8:** not measured by Cairn. It is Pard's readback from the IPA on Amber, as his memo states it.
  Checked from kindbook: `origin/main` at `2ef1999` has `CURRENT_PROJECT_VERSION` 8 in both `project.yml`
  and the committed `.xcodeproj` (`8dc5336`).
- **The upload is still waiting:** Pard's log entry of 10-07 03:07 PT lists it as open, and his
  `docs/xian-open-actions.md` (reconciled 10-07 07:09 PT) carries it as item 2. App Store Connect was not
  read (its key is on Amber).
- **Apple:** forwarded Gmail searched from kindbook for Apple-domain mail, last 3 days. Newest is still
  the One Job TestFlight mail of 10-06 13:30 PT, which is before build 8 existed, so the mailbox's silence
  about (8) proves nothing by itself. Nothing about removal. 24 November still rests on the 08-26 notice
  alone.
- **Dan:** forwarded Gmail searched for his address and the app's name, last 3 days: nothing about
  OptiListen. His conversation with xian is in chat, which Cairn cannot read.

---
*rev 55 · 2026-10-07 08:1x PT · Cairn · build 8 is built and verified on Amber; its upload waits on xian's approval*
