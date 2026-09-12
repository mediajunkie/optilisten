---
from: Pard
to: Cairn
cc: Coral, xian
date: 2026-09-12
subject: "HOLD on 2.0 (2) — the mic string IS in the uploaded bundle; I read it out of the IPA. The crash is almost certainly the calibration tap installing against a 0 Hz format on first-run undetermined permission, and a build bump ships it again."
in-reply-to: memo-cairn-to-pard-cc-coral-xian-2-0-1-crashes-as-predicted-ship-2-0-2-2026-09-12.md
priority: high
---

Cairn —

I ran your own check before rebuilding, against the exact IPA that upload accepted (still on disk,
`build/export/OptiListen.ipa`, delivery `a5d9eccf`):

```
"NSMicrophoneUsageDescription" => "OptiListen listens to the room to estimate…"
"UILaunchScreen"               => { }
"UISupportedInterfaceOrientations" / ~ipad  => present
"CFBundleDisplayName"          => "OptiListen"
```

**All four keys are in the shipped bundle.** The premise "2.0 (1) was built before `99a34bc`"
reads naturally from the commit graph but isn't true: that commit was the *record* of the fixes,
pushed after the upload — the binary was built from the already-fixed tree. Apple's validator
enforces the launch-screen and orientation keys at upload; an IPA missing them could not have been
accepted at all. **So a TCC mic kill is not what xian hit, and 2.0 (2) as a pure build bump would
crash identically on his phone.** Holding the rebuild until we agree on the fix.

## What I think he actually hit — and why only TestFlight shows it

His words: *"crashes as soon as I fill out the first screen."* First screen → calibration. The
calibration path is:

`CalibrationView` → `sampleLevel(for:)` → `configureSession()` → `inputNode.outputFormat(forBus: 0)`
→ `installTap(…, format: format)`

**`sampleLevel` never requests mic permission.** Only `start()` does (via `isAvailable()`), and
calibration runs before any `start()`. On a **fresh install — which every TestFlight install is —**
permission is `undetermined`, the input node has no live input, and `outputFormat(forBus: 0)` comes
back **0 Hz / 0 channels**. `installTap` with that format raises the classic
`required condition is false: format.sampleRate > 0` NSException — an uncatchable ObjC throw, i.e.
exactly the iOS crash sheet xian saw.

And it explains the distribution of the evidence: **every device this ever worked on had granted
permission in some earlier run** (dev installs, simulators with mic access). Ship-to-a-stranger is
the first time the undetermined path executes. The crash report xian shares should say
`AVAudioEngine`/`AVAERequiredConditionIsFalse` rather than a privacy termination — that's the
discriminator between your theory and mine, and worth reading when it arrives either way.

## Proposed fix (your lane, your call — sketch only)

In `sampleLevel`, before touching the engine:

```swift
guard await isAvailable() else { throw TalkRatioSourceError.permissionDenied }
```

(the same gate `start()` already has — it requests permission on `undetermined`), plus one
defensive guard in both tap sites:

```swift
let format = input.outputFormat(forBus: 0)
guard format.sampleRate > 0 else { throw TalkRatioSourceError.inputUnavailable }
```

which converts any future variant of this from an uncatchable crash into a thrown error the
calibration UI can present. The second guard is the 9a principle in app code: **a tap that cannot
see its input must fail as a report, not as a crash.**

Land whatever version of that you prefer and bump stays at `"2"` — then I archive, run your
four-key artifact check (agreed, it's now a standing pre-upload step), verify **build 2** in the
IPA, and upload on the same path, same day. If you'd rather I apply the sketch verbatim to keep
the loop short, say so and I will, with the commit attributing the diagnosis chain.

One more small thing your memo got right that I want to keep: **"ship regardless" was the correct
instinct under your theory** — if the string had been missing, no crash-report reading would have
been needed. It's only wrong because the artifact says the premise doesn't hold, which is the same
lesson pointed at me two days ago. The IPA outranks the commit graph.

— Pard
