# OptiListen — what needs xian

**Maintained by:** Cairn · **Updated:** 2026-10-07 16:2x PT (**rev 56**) · **Deadline:** 2026-11-24 — **48 days**, day 42 of 90

Rendered for xian at https://claude.ai/code/artifact/54087bd3-f172-494f-b79b-49d3406f5215 (same URL
every rev). This file is the source; the page follows it.

## Where things stand

- **Build 8 is in TestFlight.** Apple's "completed processing" and "available to test" mails for
  OptiListen 2.0 (8) both arrived on 10-07 at 08:59 PT, after your "go". It carries the calibration-first
  flow (D-023, [`d154f55`](https://github.com/mediajunkie/optilisten/commit/d154f55)). No run of it is
  recorded anywhere Cairn can read.
- **Dan thinks the percentage is the real problem, and he has read the app correctly.** 2.0 divides
  your talking by all the talking it detects, you plus others, and leaves quiet out. One person alone can
  therefore only read 100%. 1.x divided your talking by the whole elapsed time; that is in its source
  (`RecordSession.tsx`, lines 239-243). Dan prefers the 1.x way. You told him "we could change that
  math for sure", and to hold off testing until the next version.
- **This is the second time the same division has been expected.** On 09-26 you divided by the whole
  time yourself ("7 seconds out of 72 is it 54%?"). D-020 kept the formula and added a caption. Both
  people who have used 2.0 have now expected the other denominator.
- **Nothing has been submitted to Apple**, so 24 November has not moved.

## Needs you

Two items, about 5 minutes. The first is blocking: it decides whether build 8 or a build 9 is the one
Dan tests.

**1. 🔒 What is the percentage a share of?** Blocked since 10-07 11:0x PT. Where the action happens:
any reply to Janus or a Cairn session. The smallest answer is **"whole time"** or **"keep"**.

- **"whole time"** (your talking ÷ everything elapsed, as in 1.x). Cairn's recommendation. It is what
  you and Dan both expected on first reading. It can be tested alone: talk and it rises, stop and it
  falls. And the number then rests on one loudness line (you or not you) instead of two; the part of
  the classifier that guesses whether a moderate sound is another person, which cannot tell two voices
  in one room apart, drops out of the headline number. What it costs: quiet lowers your number, so a
  long silence reads as listening (the reason D-020 gave for leaving quiet out); a ceiling means
  something different (an even two-person conversation that is one-fifth quiet reads 40%, not 50%);
  six on-screen strings, two lines of listing copy, and the screenshots that show those strings, change. On this answer
  Cairn writes it at the next fire, Pard builds (9), and Dan waits for (9).
- **"keep"**. Then build 8 is the version you told Dan to wait for, and you can tell him it is on his
  phone. He needs a second voice to test it: a podcast playing from a laptop across the room will do.
  Alone, the number can only read 100% or nothing.

The full comparison is D-024 in [`docs/decisions.md`](decisions.md), status OPEN.

**2. Run build 8 once yourself.** Not blocking, 3 minutes, TestFlight on your phone. Tap +, then Start.
The calibration sheet should open, take its two readings, and hand you to the listening screen. That
path (a sheet opening from inside a sheet, then advancing the screen behind it) has compiled and has
never run on a device, and build 9 would inherit it. One line back: "calibration worked" or what it
did instead.

## In flight

| Owner | Item | Waiting on |
|---|---|---|
| **Cairn** | Write the denominator change as D-024 if the answer is "whole time"; `project.yml` build goes to 9 with it (Pard's note, 10-07) | Needs-you 1 |
| **xian + Dan** | Two field runs: once with a second person talking, once outdoors | whichever build Needs-you 1 settles on. Carried over from (7) |
| **Cairn** | Decide what the app says on screen about two people in one room | Needs-you 1. Under "whole time" the other voice no longer moves the number |
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

- **D-023 is in TestFlight in build 8 and no run of it is recorded** (Needs-you 2).
- **No run with a real second speaker exists on any build**, and none outdoors under the 12 dB bar.
- **48 days.** Each round is change, build, test; Apple's review comes after the last one.
- **Calibration is not remembered between launches**, so the 12-second step recurs on each cold start.
- **Nothing watches for a crash that produces no TestFlight submission** (xian, 09-14).
- **The fleet has one signing path and it expires Aug 2027**; nothing watches for expiry (Pard, 10-02).
- **Apple rejected this app once before** (July 2023, background modes). 2.0 omits `UIBackgroundModes`.
- **Age-rating social-media questions** at submission; about 10 min; the answers are "no".

## Verified how (rev 56)

- **Mail:** `docs/mail/` in this repo, 2 of 2 new memos read in full (Pard 10-07 09:0x PT; xian's chat
  with Dan relayed by Janus, 10-07 11:0x PT). Reply to Janus in `mediajunkie/designinproduct`
  `docs/mail/`. Pard's and Janus's mailboxes pulled and listed.
- **Build 8 in TestFlight:** read from the forwarded Gmail on kindbook. Two Apple mails dated
  2026-10-07 15:59 UTC, "Version 2.0 (8) for OptiListen has completed processing" and "OptiListen 2.0
  (8) for iOS is now available to test". App Store Connect itself was not read (its key is on Amber).
  Whether it is installed on anyone's phone is not visible from here.
- **2.0's formula:** read from `origin/main` at `ee11718`, `LiveMicSource.currentShare`:
  `userSpeakingSeconds / (userSpeakingSeconds + otherSpeakingSeconds)`. All eight Swift source files
  searched for other uses; the three display sites read that one property.
- **1.x's formula:** read from `AustinWood/listenup-mobile` at its default-branch head,
  `src/screens/Listen/RecordSession.tsx`: spoken seconds (or elapsed minus spoken, in listening mode)
  divided by `durationInSecond`. One file read; that repo head is 1.3 (6), not the shipped 1.1 binary.
- **Not verified:** when the chat with Dan took place relative to the 08:59 upload, so whether "the
  next version" meant build 8 is an inference from your description of it (the calibration flow).
- **Apple:** same Gmail search, last 3 days. Nothing about removal. 24 November still rests on the
  08-26 notice alone.

---
*rev 56 · 2026-10-07 16:2x PT · Cairn · build 8 is in TestFlight; what the percentage is a share of waits on xian*
