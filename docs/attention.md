# OptiListen — what needs xian

**Maintained by:** Cairn · **Updated:** 2026-10-07 16:3x PT (**rev 57**) · **Deadline:** 2026-11-24 — **48 days**, day 42 of 90

Rendered for xian at https://claude.ai/code/artifact/54087bd3-f172-494f-b79b-49d3406f5215 (same URL
every rev). This file is the source; the page follows it.

## Where things stand

- **The percentage is now your talking out of the whole time**, as in 1.0 and 1.1. You decided it on
  10-07 ("whole time"); it is D-024 in [`docs/decisions.md`](decisions.md), commit `44d273b`. It
  compiles ([CI run 37701880639](https://github.com/mediajunkie/optilisten/actions/runs/37701880639) is green: Debug, iOS Simulator). It has not run on a device, and no build 9 exists yet.
- **Build 8, in TestFlight since 10-07 08:59 PT, has the old math.** It is not the build for Dan. He is
  waiting for the next one, which is (9).
- **Practices already on your phone and Dan's will show new numbers under (9).** The app recomputes
  them from the stored you / others / quiet seconds, so history reads on one basis.
- **Nothing has been submitted to Apple**, so 24 November has not moved.

## Needs you

One item, 3 minutes, not blocking.

**1. Run build 8 once yourself.** TestFlight on your phone. Tap +, then Start. The calibration sheet
should open, take its two readings, and hand you to the listening screen. That path (a sheet opening
from inside a sheet, then advancing the screen behind it) has compiled and has never run on a device,
and build 9 inherits it unchanged. One line back: "calibration worked" or what it did instead. Ignore
the number; it is the old math.

Coming, not yet yours: Pard's seat held the (8) upload for your "go" and will probably hold (9) the
same way. It will appear here as a 🔒 when he has built it.

## In flight

| Owner | Item | Waiting on |
|---|---|---|
| **Pard** | Build 2.0 (9) from `main` and upload it; re-shoot the store screenshots that show the changed captions (scripted, D-016) | his queue; memo sent 10-07. The upload will want your "go" |
| **xian + Dan** | Run (9): alone first (talk and the number should rise, stop and it should fall), then once with a second person, once outdoors | build 9 |
| **Cairn** | Revisit the ceiling slider's range and 30% default, which were chosen for a share of speech | a run of (9) |
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
- The percentage is your talking out of the whole time (D-024, xian, 10-07).

Older closed items: [`docs/attention-changelog.md`](attention-changelog.md). Decisions:
[`docs/decisions.md`](decisions.md). Narrative: `logs/`.

## Standing risks

- **D-023 is in TestFlight in build 8 and no run of it is recorded** (Needs-you 1).
- **D-024 has been compiled, never run.** Under it a long quiet stretch lowers your number, and a
  ceiling of 30% is a looser limit than it was.
- **No run with a real second speaker exists on any build**, and none outdoors under the 12 dB bar.
- **48 days.** Each round is change, build, test; Apple's review comes after the last one.
- **Calibration is not remembered between launches**, so the 12-second step recurs on each cold start.
- **Nothing watches for a crash that produces no TestFlight submission** (xian, 09-14).
- **The fleet has one signing path and it expires Aug 2027**; nothing watches for expiry (Pard, 10-02).
- **Apple rejected this app once before** (July 2023, background modes). 2.0 omits `UIBackgroundModes`.
- **Age-rating social-media questions** at submission; about 10 min; the answers are "no".

## Verified how (rev 57)

- **The decision:** xian's reply in the Cairn session of 10-07, quoted in D-024.
- **The change:** written in the session's container against `origin/main` at `300b67c`, applied on
  kindbook with `git apply`. All ten Swift files pass `xcrun swiftc -parse` on kindbook (syntax
  only). CI run 37701880639 on 44d273b is green (Debug, iOS Simulator): a full compile, not a run.
- **Not verified:** behaviour on a device, and the store screenshots (not re-shot).
- **Build 8 in TestFlight** and **1.x's formula:** as verified at rev 56, not re-read.

---
*rev 57 · 2026-10-07 16:3x PT · Cairn · the percentage is your talking out of the whole time (D-024); build 9 is Pard's*
