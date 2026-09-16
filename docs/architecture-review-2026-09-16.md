# Why this is whack-a-mole: a five-whys on the OptiListen 2.0 capture path

**Author:** Cairn · **Date:** 2026-09-16 · **Prompted by:** xian, on the 2.0 (3) report
**Status:** grounded in a full read of `LiveMicSource.swift`, `PracticeLoopView.swift`,
`CalibrationView.swift` and `HomeView.swift` at `17e4c62`. Claims are marked
**[read]** (in the source), **[inferred]** (follows from the source but not observed on a device)
or **[candidate]** (a mechanism that fits, not established).

---

## The report

2.0 (3) — the Swift 6 isolation fix. xian: *"it did not crash immediately the way the other did,
but it did fail to start tracking anything and it did crash eventually in a similar way to
before."* His read: we're in a whack-a-mole cycle and the problem is architectural or procedural
rather than a fourth bug.

**He's right, and the reading below says why in a way that is more specific than "technical debt."**

## The five whys

**Symptom — build 3 tracks nothing, then eventually dies.**

**Why 1 — because `start()` failed and nothing told anyone.** `PracticeLoopView.swift:198` is
`try? await source.start()`. **[read]** `start()` has four throw sites: `permissionDenied`,
`inputUnavailable` (the 0 Hz guard), and anything `configureSession()` or `engine.start()` raises.
**All four are discarded by that one `try?`.** The view then renders
`Practice.percent(source.currentShare)` — which is `0` when no buffers ever arrive — so **a failed
start is pixel-identical to a working start during a silent moment.** "Tracked nothing" is the
correct observable behaviour of this code when `start()` throws. **[inferred]**

**Why 2 — because the capture path has no failure channel at all.** Every state that isn't
"working" is either *swallowed* or *fatal*, and there is no third thing.

| site | what it does with a failure | |
|---|---|---|
| `PracticeLoopView:198` | `try?` → discards the error | **[read]** |
| `CalibrationView:118,121` | `(try? …) ?? -20` / `?? -50` → **fabricates a reading** | **[read]** |
| missing `NSMicrophoneUsageDescription` | process killed by iOS, no signal | history |
| 0 Hz tap format | uncatchable ObjC exception | history |
| Swift 6 isolation | `SIGTRAP` on the audio thread | history |

**Every defect this month has presented to the user as "it crashed" or "nothing happened," and to
us as no information.** That is not four unrelated bugs; it is one property of the design producing
four indistinguishable symptoms.

**Why 3 — because `LiveMicSource` models the device as a boolean.** State is
`isRunning: Bool` plus a `wasInterrupted: Bool` flag. **[read]** The thing being modelled moves
through permission-undetermined, permission-denied, session-configured, engine-running, interrupted,
route-changed, foreground-lost and failed-with-reason. **A two-state model of an eight-state device
means six states can only appear as a crash or as silence.**

**Why 4 — because the class was written to a signal-processing brief, and the lifecycle was treated
as plumbing.** The section is literally `// MARK: Session plumbing` **[read]**, and it is nine
lines. Above it sit thirty lines of doc comment on what the measurement *means*. The care is real
and it is in the wrong half: on iOS, RMS-to-percentage is the easy part and the audio session
lifecycle is the entire difficulty.

**Why 5 — root — because nothing in the loop ever required this code to report its own state.**
It was written without a device, verified by reading, compiled on a machine that can't run it, and
shipped to a tester whose only instrument is "it crashed." Under those conditions there is no
pressure to build observability — and with no observability, every defect has to be diagnosed by
inference from source. **That inference step is exactly where Pard and I have each failed three
times this month** (his truncated ID read as an API limit; my commit graph read as a build; both of
us reading half of a two-part report). **The whack-a-mole is not bad luck. It is the direct,
predictable output of an architecture that cannot answer a question, debugged by a process that has
no way to ask one.**

---

## What the read turned up on the way

Five concrete defects, all instances of the root cause. None of these is "the crash" — I am not
proposing a fourth theory.

1. **`Calibration.unavailable` passes `isUsable`.** `userLevel: -20, ambientLevel: -50` → a 30 dB
   gap → `isUsable` is `true` (threshold is 8). **[read]** So an uncalibrated source silently
   classifies against a fabricated threshold of −36.5 dBFS. Worse, `CalibrationView`'s
   `?? -20` / `?? -50` fallbacks produce **numerically the same object**, so *total calibration
   failure is indistinguishable from a real calibration* — to the code and to the user. The
   sentinel named "unavailable" is the one value that never reports itself as unavailable.

2. **A failed `start()` leaves the session active and unclosable.** `isRunning = true` is the last
   line of `start()`; `stop()` opens with `guard isRunning else { return }`. **[read]** If
   `engine.start()` throws, the AVAudioSession is active, a tap may be installed, and `stop()` is a
   no-op forever. **[inferred]**

3. **`observeInterruptions()` adds a `NotificationCenter` observer on every `start()` and discards
   the token, so it can never be removed.** **[read]** N practice sessions → N live observers, each
   firing `wasInterrupted = true; await stop()`. A leak, and a plausible contributor to
   degradation over a session. **[candidate]**

4. **Time accounting is buffer-count × 0.1s, not elapsed time.** `classify()` adds a constant
   `bufferSeconds` per buffer **[read]**, while `bufferSize:` is only a *hint* to AVFAudio and the
   delivered frame count routinely differs. So `observedDuration` — which drives
   `evidenceCoverage` and the "treat this as a sample" footer — is a fiction that looks like a
   measurement. The README already names `evidenceCoverage` and `Calibration.threshold` as the two
   places where wrong logic yields a plausible wrong number. It was right.

5. **One `AVAudioEngine`, two owners, no arbitration.** Calibration and capture share the instance
   held by `HomeView`'s `@State`, both install a tap on bus 0, and `sampleLevel()` calls
   `engine.stop()` unconditionally. **[read]** Any overlap is an uncatchable ObjC exception rather
   than an error. **[candidate]** for "crashed eventually."

---

## What to do instead of a fourth fix

**1. Ship one build that reports, and fix nothing else in it.**
- Replace every `try?` and `??` in the capture path with a state the UI can render.
- `enum CaptureState { case idle, requestingPermission, starting, running, interrupted, failed(String) }`,
  surfaced on the listening screen — a single line under the number is enough.
- A rolling in-app event log (start, permission result, sample rate, frames-per-buffer, buffers
  received, every error) that the tester can copy out.
- **This converts every future report from "it crashed" into a fact, permanently.** It is the only
  change that pays for itself across all remaining bugs.

**2. Make "I don't know" representable.** `calibration: Calibration?`; delete `.unavailable`; the
UI already has an honest no-reading path and should use it.

**3. Model the lifecycle rather than flag it.** One state machine, one owner of the engine,
`stop()` reachable from every non-idle state.

**4. Fix the accounting** to use `Double(buffer.frameLength) / format.sampleRate`.

**Only then resume fixing the crash** — with a stack *and* a state trace, instead of a stack alone.

## The release valve nobody has said out loud

**Live capture is not required for App Store compliance, and it is not required for the product
argument.** The loop closes on intention + reflection; `ManualSource` exists; `Practice.isComplete`
deliberately ignores measurement. **[read]** So there is a shippable build in which live capture is
disabled behind a flag, the manual number is the only path, Apple's deadline is satisfied, and the
microphone work comes off the critical path entirely.

That is not a recommendation yet — it trades a working prototype in Dan's hands for certainty
against 24 November. But with 69 days left and three failed builds, **it should be a live option
rather than a thing we discover in November.**

— Cairn
