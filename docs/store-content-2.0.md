# App Store content pass — OptiListen 2.0

**Date:** 2026-09-22 · **Author:** Cairn · **Status:** reviewable draft, nothing published
**Prompted by:** xian, relayed through Pard 2026-09-22 — no submission date until Dan's test; do the
content pass now so that when the gate is passed, submission is same-day work.

Every field below is a draft for **xian to publish**. App Store Connect is behind `xian@pobox.com`
and nothing here has been entered anywhere. Character counts are against App Store Connect's limits
and were computed, not estimated.

**Evidence labels are used throughout.** [EVIDENCED] means a command was run or a page read this
pass and the output is quoted. [INFERRED] means it is my reading. [OPEN] means I could not
determine it.

---

## 0. Three findings that are worth more than the copy

Put first because two of them are decisions, not drafting.

### Finding 1 — the live description tells users to do the one thing 2.0 refuses to measure

[EVIDENCED] The listing at `apps.apple.com/us/app/optilisten/id1593948410`, read 2026-09-22, opens
its description with: *"Put your headphones on, start a session, set a goal, and see how you do."*

[EVIDENCED] `PracticeLoopView.swift:66` — `guard !usingHeadphones, source.calibration.isUsable, …`
with the comment *"Headphones mean the microphone only ever heard the user, so the ratio is
meaningless. Record the duration, refuse the number."*

So the shipped copy instructs the exact configuration under which 2.0 deliberately produces no
reading at all. `CalibrationView.swift:100` names headphones first among the causes of an unusable
room. This is not a nuance to soften in the rewrite — **the first sentence of the current listing
has to go**, and the replacement has to say the phone listens to the room.

It is also the fourth member of the class that has cost us twice already: metadata the compiler
never checks and the submission does. The bundle ID was first, the `Info.plist` version string
second, the iOS 11→17 minimum third and clean. This one is not clean.

### Finding 2 — the app is universal, so iPad screenshots are required

[EVIDENCED] `OptiListen.xcodeproj/project.pbxproj:276,355` — `TARGETED_DEVICE_FAMILY = "1,2"`.
`project.yml` never sets it, so XcodeGen's universal default stands, and `Info.plist` carries a
full `UISupportedInterfaceOrientations~ipad` array.

[EVIDENCED] Apple's screenshot specification, read 2026-09-22: iPad **13" (2064 × 2752 or
2048 × 2732 portrait)** is *"Required if app runs on iPad."* iPhone requires the 6.5" set
(1284 × 2778) unless 6.9" (1320 × 2868) is supplied; every other size is scaled.

**This is a decision for xian, and it is cheap either way:**

- **Keep iPad.** Cost is one more screenshot set and one more device family that has never been
  run. 2.0 has been tested on exactly one iPhone. An untested iPad layout is a rejection surface on
  an app that has already been rejected once.
- **Drop to `TARGETED_DEVICE_FAMILY = "1"`.** One line in `project.yml`, removes the iPad
  screenshot requirement and the untested family. [INFERRED] It also narrows what customers who
  already own the app on iPad can install; 1.1 predates my evidence and I have not established
  whether it was ever universal, so I am not recommending this without that read.

[OPEN] Whether shipped 1.1 was universal. Answerable from the 1.x `project.pbxproj` in
`AustinWood/listenup-mobile`, which is not cloned on this machine.

My recommendation, held lightly: **drop to iPhone-only** if the 1.x read says 1.1 was
iPhone-only, and keep iPad otherwise. Either way it should be settled before art is cut, because
it changes how many sets get made.

### Finding 3 — the screenshot pass needs about ten lines of code first

[EVIDENCED] `TalkRatioSource.swift:47` — the listening screen takes a `LiveTalkRatioSource`, whose
`currentShare` and `observedDuration` are `@MainActor` and whose only implementation is
`LiveMicSource`. `ManualSource` (`RetrospectiveSources.swift:12`) conforms to the plain
`TalkRatioSource` only, so it cannot drive that screen.

The Simulator has no microphone. Two of the six shots below are of the live screen with a number
on it. **They cannot be captured in a Simulator as the code stands.** The fix is a debug-only
fixture source conforming to `LiveTalkRatioSource` that returns a fixed share and a running clock —
small, Pard's lane, and it should be `#if DEBUG` so it cannot reach a release build. Capturing on
xian's physical iPhone instead is possible but gives one device size and no iPad.

---

## 1. Listing metadata

### App Name — no change

`OptiListen` (10 / 30). It is the App Store record's name and the domain. Nothing recommends
changing it.

### Subtitle — change

**Current** [EVIDENCED, read 2026-09-22]: `Unlock the listener within` (26 / 30).

It is a 2021 self-help line for a measurement app. 2.0 is a rehearsal loop, and the subtitle is
the second thing a browser reads.

**Recommended:** `A rehearsal for listening` (25 / 30)

Alternates, ranked: `Practice talking less` (21 / 30) — plainer, slightly blunter than the product
is. `Talk less, on purpose` (21 / 30) — good, but "on purpose" reads as a joke in search results.

### Promotional Text — new, and worth having

170 characters, **editable at any time without submitting a build**. Nothing occupies it now. It is
the one field that can carry a beta note, a price note or a seasonal line without a review cycle.

**Draft** (156 / 170):

> Rebuilt from scratch for 2026: set a ceiling before a conversation, see where you are while you
> can still act on it, and say afterward how present you were.

### Description — rewrite

**Current** [EVIDENCED, read 2026-09-22], reproduced in full because Finding 1 turns on it:

> OptiListen is an easy to use app, created by and for folks who would like to listen a little
> more. Put your headphones on, start a session, set a goal, and see how you do. With OptiListen,
> you can track your results over time, and build your listening skills, one audio or video call at
> a time. Note: We're launching OptiListen as a free app and all data is kept locally on your
> phone.

**Proposed** (2,181 / 4,000):

> **Talking less is a skill, and skills need practice.**
>
> OptiListen is a rehearsal loop for listening. Before a conversation you set a ceiling — the share
> of it you mean to spend talking — and name one thing you are practising. During the conversation
> you can leave the phone face up beside you and see where you are while you can still do something
> about it. Afterwards you say how present you actually were.
>
> That loop is the product. The microphone is optional.
>
> **Before.** Pick your ceiling. Write one line about what you are working on — "ask before
> answering," "let the silences run." One line, because it has to be something you can remember
> mid-sentence.
>
> **During.** Set the phone face up, an arm's length away, and stop looking at it. A single number
> shows how much of the talking has been yours. It settles once a second instead of twitching, it
> goes green while you are inside your ceiling and amber when you cross it, and it taps you once
> the first time you go over. That is the whole of what it does during a conversation, and that is
> deliberate — anything that pulls your eyes off the person you are talking to is a defect.
>
> **After.** Rate how present you were, one to five, in your own judgement. Not the microphone's.
> You can hit your number exactly and still have been somewhere else entirely. Write a line about
> it if you want to. The loop closes whether or not a number was ever measured.
>
> **About the listening.** OptiListen estimates how much of a conversation is you by measuring
> loudness on your device. **Nothing is recorded, nothing is transcribed, and nothing is sent
> anywhere.** A short calibration teaches it the difference between your voice and your room; if
> the room is too loud, or you are on headphones, it will tell you it cannot give you a reliable
> number rather than giving you one anyway. Practising without a number is a perfectly good way to
> use this.
>
> **What it will not do.** It does not run in the background — the phone stays awake with the app
> on screen, an instrument you set down rather than one you forget. It does not join your calls,
> connect to your meeting tools or create an account. Everything stays on your device.
>
> Free, no account, no ads, no tracking.

Notes on what that copy is doing, so a later pass does not relitigate it:

- It promises **no background operation**, in the listing, before anyone downloads it. 1.x was
  rejected in July 2023 over background-mode changes and shipped a warning popup as an apology for
  the constraint. 2.0 does not declare `UIBackgroundModes` at all ([EVIDENCED] `project.yml`:
  *"Deliberately absent: UIBackgroundModes"*). Stating the limitation as a design choice is both
  honest and the strongest possible position in review.
- It says the number can be refused. That is the behaviour, and a listing that over-promises a
  measurement this app deliberately withholds generates one-star reviews.
- It leads with practice, not measurement. Every meeting tool now reports talk ratio for free; the
  defensible position is the loop.

### Keywords — rewrite

**Current** [OPEN] — the keyword field is not visible on the public listing and I have no App Store
Connect access. It must be read before being replaced.

**Proposed** (91 / 100, comma-separated, no spaces — spaces waste characters):

```
listening,active,talk,ratio,meetings,coaching,communication,practice,presence,habit,mindful
```

App name and subtitle are already indexed, so "OptiListen", "rehearsal" and "listening" as a phrase
are not repeated here.

### Category, age rating, URLs

| Field | Current [EVIDENCED 2026-09-22] | Proposed |
|---|---|---|
| Primary category | Productivity | unchanged |
| Secondary category | [OPEN] not shown publicly | Health & Fitness, if empty — the practice framing sits there naturally |
| Age rating | 4+ | unchanged; see §2.4 for the new questionnaire |
| Support URL | `https://optilisten.com` | unchanged — **but see below** |
| Marketing URL | `https://optilisten.com` | unchanged |
| Privacy Policy URL | `https://optilisten.com/privacy/` | unchanged — **but see below** |
| Copyright | [OPEN] | `2026 Long Sky Media` |
| Price | Free | unchanged |

⚠️ **Both URLs point at a site that has not been touched since February 2023** and describes the
1.x product. `Design-in-Product/optilisten` is live at that domain and dormant by design. The
privacy policy in particular is a submission surface: it must describe what 2.0 does, and 2.0's
data story is *simpler* than 1.x's, so this is a short edit rather than a rewrite. **Not drafted
here** — it is a separate repo and a separate pass. Flagged so it does not surface on submission
day.

---

## 2. The new-release and review forms

### 2.1 Version record

[EVIDENCED] `GET /v1/apps/1593948410/appStoreVersions`, read by Pard 2026-09-21: exactly two
records, 1.1 `READY_FOR_SALE` and 1.0 `REPLACED_WITH_NEW_VERSION`. **No 2.0 record exists.** It is
created at submission as version string `2.0`, and build `2.0 (5)` — or whatever build has by then
passed Dan's test — is attached to it.

### 2.2 What's New in This Version

**Draft** (780 / 4,000):

> OptiListen 2.0 is a rebuild, not an update.
>
> The app is now a practice loop rather than a scorekeeper. You set a ceiling before a conversation
> and name one thing you are working on; you can watch a single quiet number while the
> conversation happens; afterwards you say how present you were, in your own judgement, and that is
> what closes the loop. A conversation you reflected on counts whether or not anything was
> measured.
>
> Also new: a calibration step that learns the difference between your voice and your room, and
> tells you honestly when it cannot give you a reliable reading instead of giving you a number you
> should not trust. Everything is computed on your device. Nothing is recorded, transcribed or
> sent anywhere.
>
> Rebuilt natively for current iPhones. Requires iOS 17.

### 2.3 App Review Information — notes to reviewer

This is the field that matters most, because the app asks for the microphone, has one prior
rejection on the record, and has a diagnostics affordance a reviewer will find and wonder about.

**Sign-in required:** No. **Demo account:** not applicable — there are no accounts.

**Draft notes:**

> OptiListen is a listening-practice app. It is a complete rebuild of version 1.1 (2023) in
> SwiftUI, on the same bundle identifier.
>
> **How to exercise the app in about two minutes.** Launch it and tap the button to start a
> practice. On the "Before" screen set a ceiling percentage and type one line in "What are you
> practising?", then tap Start. Grant the microphone prompt. Talk for thirty seconds or so and a
> percentage appears; tap End. On the "After" screen choose a presence rating of 1–5 and tap Done.
> The practice then appears on the home screen. No account, no network connection and no purchase
> is required at any point.
>
> **Microphone use.** The app taps the input at 100 ms intervals, computes a loudness (RMS) value
> per buffer, classifies it as you speaking, someone else speaking or silence, and discards the
> buffer. **No audio is recorded, written to disk, transcribed, or transmitted.** There is no
> speech recognition framework in the app and no network code of any kind. The privacy manifest
> declares no collected data types and one required-reason API (`UserDefaults`, CA92.1).
>
> **Calibration.** "Calibrate" in the home toolbar takes two short readings — one of the reviewer
> speaking, one of the room — to establish the gap between them. It is optional; the app works
> without it and says so on screen when a number is computed against placeholder thresholds. If
> the room is too loud or headphones are in use, the app reports that it cannot produce a reliable
> reading and offers to continue without one. That refusal is intended behaviour, not a failure.
>
> **Diagnostics.** The listening screen has a stethoscope button that opens a plain-text event log
> and a copy button. It is a support affordance for a measurement users are asked to trust; it
> contains timestamps and state transitions only, no audio and no personal data.
>
> **Background behaviour, and the 2023 rejection.** Version 1.1 was rejected in July 2023 over
> background-mode changes and shipped with a warning that it could not score while backgrounded.
> **2.0 declares no background modes at all.** It is designed to be used with the screen on and the
> phone face up on the desk; sending it to the background simply ends the reading. This is stated
> in the App Store description so that users know it before downloading.
>
> **Minimum iOS.** 1.1 shipped at iOS 11; 2.0 requires iOS 17. The app's own analytics show every
> download since 2024 was on iOS 17 or later, so no current user loses access.

### 2.4 Age rating questionnaire

[EVIDENCED] Apple added in-app social-media and messaging questions to the age-rating
questionnaire, required at submission as of September 2026
(`developer.apple.com/news/?id=tlur8uvi5`).

Answers, all derived from the source: **No** to every content category, **No** to user-generated
content, **No** to messaging or chat, **No** to social-networking features, **No** to unrestricted
web access, **No** to gambling, contests and in-app purchases. The app has no network code. Result
should remain **4+**. Approximately ten minutes of clicking, none of it discretionary.

### 2.5 Encryption and privacy declarations

- `ITSAppUsesNonExemptEncryption = false` is already in `Info.plist` and in `project.yml`'s
  `info.properties` [EVIDENCED], so the upload will not stall on the export-compliance question.
- App Privacy nutrition labels must read **"Data Not Collected"** across the board, matching
  `PrivacyInfo.xcprivacy` [EVIDENCED: `NSPrivacyTracking false`, empty
  `NSPrivacyCollectedDataTypes`, empty tracking domains]. These are answered in App Store Connect
  separately from the manifest and a mismatch between the two is a known rejection cause.
- The manifest carries Pard's own standing note: re-check it against the final dependency list
  before submitting. 2.0 has no third-party SDKs today.

---

## 3. Screenshot art

### What exists now

[EVIDENCED] The live listing shows the 1.x set, shot in 2021 against the React Native app. It
predates the moss/amber design pass, the recovered icon, and every screen 2.0 has. xian's word for
it, relayed 2026-09-22: it *"still reflects the old branding and design."*

### Sizes to produce

| Set | Pixels (portrait) | Required? | Capture device |
|---|---|---|---|
| iPhone 6.9" | 1320 × 2868 | Accepted in place of 6.5"; **recommended** — it is the native size of current hardware and everything else scales from it | Simulator: iPhone 17 Pro Max or equivalent 6.9" |
| iPhone 6.5" | 1284 × 2778 | Required **only if** 6.9" is not supplied | — |
| iPad 13" | 2064 × 2752 | **Required while the app is universal** — see Finding 2 | Simulator: iPad Pro 13" |

Maximum ten per size; `.png`, no alpha channel. [EVIDENCED from Apple's screenshot specification,
read 2026-09-22.]

### The sequence — six shots, keeping the 1.x structure

`docs/COMPLIANCE.md` item 6 says to keep the 2021 structure — goal → live → reflection → reward —
and that still holds; it is the loop, and it is what the product is now explicitly about. Shot 4 is
the one addition, and it exists to make the semantic colour pair legible in a still image.

| # | Screen | State to stage | Caption |
|---|---|---|---|
| 1 | Home, empty | Before any practice exists. Copy on screen: *"Set an intention before your next conversation."* No counter — the design pass removed the 52-point "0". | **Listening is a practice.** |
| 2 | Before | Ceiling at 30%, focus line reading *"Ask before answering."* | **Decide how much you mean to talk.** |
| 3 | Listening, within | ~22% in moss green, elapsed around 06:30, focus line visible under the numeral | **See it while you can still change it.** |
| 4 | Listening, over | ~41% in amber, over-ceiling line showing | **Green under your ceiling. Amber over it.** |
| 5 | After | A measured share with the `you · others · quiet` breakdown beneath it, presence set to 4 | **How present were you? Your call, not the microphone's.** |
| 6 | Home, with history | Five or six closed practices, the counter showing, the goal chart populated with a visible downward drift | **A conversation at a time.** |

Staging notes: use plausible labels (*"1:1 with Dana"*, *"Team standup"*, *"Call with Dan"*) and
avoid real names other than xian's own. Shot 3's number must be **inside** the ceiling and shot 4's
**outside** it, or the colour pair reads as decoration. Shot 6's chart is the only shot that needs
seeded history; a handful of `Practice` rows inserted into the SwiftData store under `#if DEBUG`
covers shots 1–6 and the fixture source from Finding 3 covers shots 3 and 4.

Light mode for all six. `Theme` defines both, and the dark variants are legible, but a mixed set
looks like an accident rather than a choice.

### Not doing

No device frames, no marketing captions burned into the image, no gradient backgrounds. The 2021
set did not have them; the app's whole argument is restraint; and framed screenshots date faster
than plain ones. If xian wants captions rendered into the art rather than shown as plain
screenshots, that is a deliberate reversal and worth one line from him.

### Icon

[EVIDENCED] `project.yml`: the current icon is the **original 1.x App Store icon**, recovered from
Apple's artwork CDN on 2026-09-11 because the 2.0 rebuild had no asset catalog at all. The design
pass lists it as open: *"worth asking whether it still represents a practice tool rather than a
measurement tool."* Recording it here because submission is the natural moment to decide, and
because it is the one piece of art in this pass that has a 2021 provenance and no 2026 decision
behind it. Not blocking.

---

## What this pass did not do

- **Nothing was published.** Every field above is a draft; App Store Connect is behind
  `xian@pobox.com`.
- **No screenshots were taken.** kindbook has no Xcode [EVIDENCED, and the machine this ran on],
  the shots need Amber, and two of the six need the fixture source first.
- **The keyword field and the secondary category were not read**, because they are not public.
  Both must be read before being overwritten.
- **The privacy policy at `optilisten.com/privacy/` was not reviewed.** Different repo, and it is a
  submission surface that should not be discovered on submission day.

— Cairn, 2026-09-22
