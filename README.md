# OptiListen 2.0

A practice loop for listening. Native SwiftUI, iOS 17+, everything on device.

Replaces the 2021–23 React Native app (`AustinWood/listenup-mobile`), which is
unrecoverable from here and would have needed a four-year framework upgrade to
build against the iOS 26 SDK anyway. Same bundle ID, same App Store listing.

---

## The argument

OptiListen 1.x measured how much of a call you spent talking. That capability is
now free and ambient — Zoom, Teams, Granola, Gong and Fathom all report talk
ratio at higher fidelity, without you starting anything. Rebuilding a measurement
app in 2026 means competing with the operating layer of every meeting tool.

But none of those tools asks you to **commit to something beforehand**, shows you
the gap **while you can still act on it**, or makes you **say how present you
were** afterward. They produce analytics about a meeting. OptiListen produces a
rehearsal for a person. That's the position.

So the unit here is the loop, not the number:

```
intention  →  conversation  →  reflection
  (before)      (during)         (after)
```

The home screen counts **closed loops**, not average talk ratio. A practice with
an intention and a reflection but no measurement is complete. A practice with a
perfect ratio and no reflection is not. That inversion is the product.

## Where the number comes from

Behind `TalkRatioSource`, so the loop never depends on any one of them:

| Source | Status |
|---|---|
| `LiveMicSource` | Ships now. On-device, foreground, loudness only. |
| `ManualSource` | Ships now. The user's own estimate. Always available. |
| `GranolaSource` | Shaped, not built — see below. |

**Verified 2026-09-06, before writing any of this:** Granola's API requires a
Business plan and transcripts are paid-tier only (a live request against a free
account returns *"Transcripts are only available to paid Granola tiers"*). Zoom
exposes no per-participant speaking-time endpoint — it's been an open feature
request on their developer forum for years. Gong does expose talk ratio, but
that's enterprise sales software, not something an individual practitioner has.

So "read the number the incumbents already produce" has no data source for a
single user today. It's built as an adapter boundary rather than a dependency:
if access opens up, `GranolaSource` becomes real and nothing downstream changes.

## The background-mode decision

**2.0 does not run in the background, on purpose.**

From the 2022–23 mail archive: background capture worked ~30 seconds
(Austin, 2023-03-31), was raised to 50 (Alexis, 2023-05-17), prompted a
discussion about adding a popup *warning users about the time limit*
(2023-05-18), and Apple rejected a build over the background-mode changes
(Austin, 2023-07-11). Shipped 1.1 therefore reported a confident ratio derived
from under a minute of a meeting.

iOS suspends audio capture for a backgrounded app that isn't playing audio. That
is not a bug to engineer around; it's the platform. So the model changed instead:
the phone is an instrument you set face-up beside you with the screen on, like a
metronome. `UIBackgroundModes` is deliberately absent from `project.yml`, which
also removes the one thing this app has already been rejected for.

Consequences, all surfaced in the UI rather than hidden:

- Headphones mean the mic only hears you, so the session runs with **no number**
  and the intention does the work.
- Calibration can **fail honestly** — if your voice and the room are within 8 dB,
  the app says so instead of shipping a wrong ratio.
- Every reading carries its **coverage**. Eight minutes of a forty-five minute
  call is labelled a sample, not a verdict.

## Layout

```
OptiListen/
  Models/Practice.swift          the loop as data; isComplete ignores measurement
  Sources/TalkRatioSource.swift  the protocol boundary
  Sources/LiveMicSource.swift    AVAudioEngine tap, RMS classification
  Sources/RetrospectiveSources.swift  manual + Granola adapter
  Views/HomeView.swift           closed loops, trend, history
  Views/PracticeLoopView.swift   intention → listening → reflection
  Views/CalibrationView.swift    teaches your voice from the room
  Support/PrivacyInfo.xcprivacy  required for submission
project.yml                      XcodeGen spec
```

## Build

```
brew install xcodegen
xcodegen generate
open OptiListen.xcodeproj
```

Or make the target by hand — nothing depends on the generated project.

**Pard, before the first build:**

1. Set `DEVELOPMENT_TEAM` in `project.yml`.
2. Confirm `com.optilisten.ios` is still registered at
   https://developer.apple.com/account — it's the existing App Store record's
   bundle ID and must not change.
3. Verify the Apple Developer Program membership is current. In July 2023 an
   unsigned Program License Agreement blocked publishing and had to be chased
   twice; three years on it's live risk with its own turnaround.
4. This code has **never been compiled** — it was written in a Linux container
   with no Swift toolchain for SwiftUI. Expect the first build to surface real
   errors. Treat them as a first draft's, not a design's.

## Known gaps

- `HomeView` deferred-reflection row links to a placeholder; the resume-a-
  reflection flow is the next thing to build.
- Calibration is not persisted between launches — needs to land in `UserDefaults`
  or SwiftData, and to expire when the user's environment changes.
- No onboarding. First launch should route through calibration.
- No tests. `Practice.evidenceCoverage` and `Calibration.threshold` are the two
  places where wrong logic silently produces a plausible wrong number, so they
  are where tests should start.
- Screenshots for the App Store listing need regenerating on a current
  simulator. Keep the 1.x structure — goal → live → reflection → reward — it
  communicated the product well.
