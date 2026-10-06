# OptiListen — decision register

**Maintained by:** Cairn · **Started:** 2026-09-24 · **Scope:** OptiListen 2.0

Design decisions get called and tracked here, the same way status gets tracked in
`docs/attention.md`. The two files do different jobs: **attention.md says what is
happening; this says what was decided and why.** A decision that only exists in a
commit message, a memo or somebody's memory is not tracked — this register is where
it is findable six weeks later, when the question comes back around and nobody
remembers whether it was settled or just drifted.

**Why this exists.** On 2026-09-24 a screenshot put two screens side by side and
showed that the app rendered the same fact two different ways. The colour pair had
been decided on 09-21 and written into `Theme.swift`'s doc comment, but only one of
the three screens that needed it ever got it — and nothing anywhere recorded that
it was supposed to be universal. **The decision existed; the tracking did not.**

## How to read an entry

- **Status** — `DECIDED` (settled and implemented) · `OPEN` (called out, awaiting a
  decider) · `SUPERSEDED` (by a later D-number, named).
- **Decider** — who made the call. xian decides product and design direction;
  Cairn decides copy and rollup framing; Pard decides build sequencing and
  same-pattern code repairs.
- **Shows up in** — where the decision is visible, so it can be checked rather
  than believed.

---

## D-001 · Rebuild native rather than upgrade 1.x
**2026-09-06 · xian · DECIDED**

2.0 is a native SwiftUI app, not an upgrade of `AustinWood/listenup-mobile`
(React Native 0.66, with the framework itself patched). The 1.x source stays a
read-only spec.

**Why:** the upgrade path ran through a patched RN framework for an app with 96
lifetime downloads. A rewrite of a small app was cheaper than reviving a large
toolchain.

**Shows up in:** `github.com/mediajunkie/optilisten`, the whole 2.0 tree.

---

## D-002 · The loop is the product; the microphone is optional
**2026-09-06 · xian · DECIDED**

The product is intention before / gap during / self-rated presence after.
Measurement is an input to that loop, not the loop itself. `Practice.isComplete`
deliberately ignores measurement, and `ManualSource` exists so a practice can
close with no microphone at all.

**Why:** it makes the app useful in rooms where capture cannot work, and it is
what makes the flag-off-capture fallback build shippable if 24 November gets tight.

**Shows up in:** `Practice.isComplete`, `ManualSource`, and the "After" step
accepting a presence rating with no number.

---

## D-003 · Plainness is a decision, not an absence
**2026-09-21 · xian (ratified Cairn's pass) · DECIDED**

The app stays visually quiet, but every quiet choice has to be chosen. Before this,
every control sat where SwiftUI put it, in system blue, at default weight.

**Why:** during a conversation the app's job is to be uninteresting — but
undesigned and deliberately restrained look identical in a screenshot and are not
the same thing. Restraint is the subject, so the interface should model it.

**Shows up in:** `docs/design-pass-2026-09-21.md`; D-004 through D-007 are its
individual items.

---

## D-004 · One semantic colour pair: moss within, amber over
**2026-09-21 · xian · DECIDED** · extended by D-009, D-010

`Theme.within` (moss) means inside your intention; `Theme.over` (amber) means past
your ceiling. A pair, not decoration. Deliberately not system blue, and
deliberately not red.

**Why, in the Theme's own words:** it "says which side of your own intention you
are on without needing a label, which matters because the person reading it is
mid-conversation and not really reading." An alarm colour would overstate something
the user is meant to notice calmly and adjust.

**Shows up in:** `OptiListen/Support/Theme.swift`.

---

## D-005 · The End button is not destructive red
**2026-09-21 · xian · DECIDED**

**Why:** a filled destructive-red button was the loudest element on a screen whose
entire subject is listening quietly.

**Shows up in:** `PracticeLoopView`, the listening step's toolbar.

---

## D-006 · The live number settles on the one-second tick
**2026-09-21 · xian · DECIDED**

The share redraws once a second (`shownShare`), not on every 100 ms buffer, and
`overGoal` reads from the settled value.

**Why:** a number twitching ten times a second pulls the eye of someone who is
supposed to be looking at a person. It also made the ceiling crossing fire
repeatedly on values wobbling over the line.

**Shows up in:** `PracticeLoopView`, the `tick` receiver and `shownShare`.

---

## D-007 · Two haptics, and only two
**2026-09-21 · xian · DECIDED**

One at the first ceiling crossing, one when the loop closes. Once per session on
the crossing, not per buffer.

**Why:** the phone is face-up and unwatched, so touch is the only channel that
reaches the user without making them look. That privilege is spent on the one
event worth interrupting for.

**Shows up in:** `PracticeLoopView`, `.onChange(of: overGoal)`.

---

## D-008 · iPhone only — `TARGETED_DEVICE_FAMILY: "1"`
**2026-09-23 · Cairn evidenced, xian's scope to set · DECIDED**

2.0 drops iPad. XcodeGen's default had silently made it universal.

**Why:** shipped 1.1 was iPhone-only, evidenced three ways — the 1.x
`project.pbxproj` sets no `TARGETED_DEVICE_FAMILY` and its `Info.plist` no
`UIDeviceFamily`; the live App Store Compatibility block lists iPhone, iPod touch,
Mac and Apple Vision but no iPad; the iTunes lookup returns four iPhone and zero
iPad screenshots. **So no existing customer owns this on an iPad, and dropping it
costs nobody anything** — while removing a required iPad screenshot set and an
untested device family from an app already rejected once.

**Caveat kept in the open:** that lookup's `supportedDevices` does list 80 iPad
entries. That field is what can *run* the binary in compatibility mode, not what
the app offers. Do not cite it for device family.

**Shows up in:** `project.yml`, with the evidence in the comment.

---

## D-009 · An under-ceiling number is green, on every screen that shows one
**2026-09-24 · xian · DECIDED**

The `within`/`over` pair from D-004 applies wherever the app states which side of
the ceiling you are on — the live Listening numeral, its ceiling caption, the
After card's numeral and its ceiling caption, and the Home list. Not just where it
happened to get applied first.

**Why:** the app was rendering one fact three ways. Home coloured an under-ceiling
number moss; Listening and the After card left it black; all three turned amber
when over. D-004's own stated rationale — "the person reading it is mid-conversation
and not really reading" — describes the Listening screen precisely, and that was the
one screen without it. So this is not a new colour; it is D-004 finally landing in
the place it was written for.

**How it surfaced:** a six-shot screenshot set put the three screens side by side
for the first time. Worth keeping: **the inconsistency was invisible in the source
and obvious in the artifact.**

**Shows up in:** `PracticeLoopView.swift` (the live numeral, its caption, the After
card numeral and its caption), `HomeView.swift:168`. Re-shot in
`docs/store-art/6.9-inch/` shots 3 and 5.

---

## D-010 · The two tokens are the whole palette
**2026-09-24 · Cairn · DECIDED** · direct consequence of D-009

No raw `.orange`, `.green`, `.red` or `.blue` anywhere in the views. Everything is
`Theme.within` or `Theme.over`. Two further calls inside this one:

- **`over` carries two meanings, deliberately:** "you are over your ceiling" and
  "this reading is not trustworthy." Both say *the number needs your attention*.
  Giving the second its own token would have made a deliberate pair into a trio for
  no gain.
- **There is no red in this app.** A calibration that did not run is not an
  emergency either, and it now reads `Theme.over` like every other caveat.

**Why:** the sweep behind D-009 found eleven raw system colours — six `.orange`
warnings, a `.green` checkmark, a `.red` failure, a `.blue` step prompt. SwiftUI's
`.orange` is visibly brighter than `Theme.over`, so the app was already showing two
ambers that meant different things, and the difference was accidental rather than
designed. **An untokenised colour that happens to resemble a token is exactly how
two screens end up disagreeing about the same fact** — which is D-009's whole story.

**Shows up in:** `Theme.swift`'s doc comment now states this, so the spec matches
the code; `grep -rn 'foregroundStyle(\.\(orange\|green\|red\|blue\)' OptiListen`
returns nothing, and that is the check.

---

## D-011 · Chart points carry the ceiling colour; the line stays neutral
**2026-09-24 · Cairn raised, xian ruled, Pard built · DECIDED**

The Home chart's trend line runs through points on both sides of the ceiling, so
**no single colour for the series can be right.** It was raw `.orange`; tokenising
it to `Theme.over` would assert "over ceiling" for every point, including the ones
under it. The line is neutral (`.primary`) as an interim, with the goal line
dashed and secondary as before.

**The proposal:** leave the line neutral and colour the point symbols
`metGoal ? Theme.within : Theme.over`, so the chart says the same thing the
numerals say.

**Why it was open rather than done:** it needs per-point marks in the Chart body
rather than a colour literal, and kindbook has no SDK — `swiftc -parse` catches
syntax and nothing else. This project has twice shipped uncompiled changes.
**Pard's, on Amber, with a compiler.**

**DECIDED and built 2026-09-24 (Pard, `129dd20`).** xian's instinct was to colour
the whole line by the *most recent* status; the proposal above won on the same
ground the original finding stood on — the latest point's side is still a claim
about every point behind it. The rightmost mark is where the eye lands anyway, so
"how am I doing now" is answered without the line asserting it about last month.

**What building it exposed, which is the part worth keeping:** the neutral line
rendered **moss green**. Bare `.primary` in a `ShapeStyle` position is
`HierarchicalShapeStyle.primary` — "the primary level of the *current* foreground
style" — and `OptiListenApp` sets `.tint(Theme.within)`, so it inherited the tint
and drew a ceiling-crossing series entirely "within": exactly the falsehood this
entry exists to prevent, arrived at by inheritance rather than by anyone choosing
it. Same for the goal line's `.secondary`, quietly tinting the ceiling reference.
Now `Color.primary` / `Color.secondary`, explicitly.

**It compiles clean either way, and D-010's raw-colour grep cannot see it** — the
token discipline has a level below the one that sweep reached. Found only by
opening the image (D-017), the day after that entry was written against myself.

**Shows up in:** `HomeView.swift` `GoalChart`, with the reasoning in the comments.

---

## D-012 · "practicing", US spelling
**2026-09-24 · Cairn (copy) · DECIDED**

**Why:** the app shipped both spellings. Shots 3 and 4 read `PRACTISING`; shot 2
asks "What are you practicing?" and shot 5 says "You were practicing:" — both
visible in the store art one swipe apart, where a reviewer sees them. US listing,
US seller, so US spelling.

**Shows up in:** three strings in `HomeView.swift` and `PracticeLoopView.swift`;
`grep -rn practising OptiListen` returns nothing.

---

## D-013 · Screenshot order leads with the history shot
**2026-09-24 · Cairn (content) · DECIDED, reversible**

Upload order 6 → 4 → 2 → 3 → 5 → 1 rather than 1 → 6.

**Why:** the App Store shows the first one or two without a swipe. Shot 1 is the
empty state — honest, and the right screen to own, but two-thirds empty frame that
sells nothing. Shot 6 carries the whole argument in one image: a count, a downward
drift crossing the ceiling, and four real rows.

**Cost to reverse:** none. It is the upload order, not the art.

---

## D-014 · Mac and Apple Vision availability — not claimed
**2026-09-23 · raised by Cairn · DECIDED by xian 2026-10-02: 2.0 does not claim Mac or Apple Vision support**

The live listing shows 1.1 available on Mac (Apple silicon) and Apple Vision.
[INFERRED] that is the per-app App Store Connect availability setting, so 2.0
inherits it unless unchecked. 2.0 is portrait-only, opens the microphone on launch,
and has run on exactly one iPhone.

**It is a checkbox**, in App Store Connect, which is behind xian@pobox.com. Still to do: uncheck
both when the 2.0 version record is created. Nothing in the repo changes.

---

## D-015 · The device-family change lands in (6), never in (5)
**2026-09-23 · Pard · DECIDED**

`TARGETED_DEVICE_FAMILY` (D-008) is a build setting, so it cannot reach the build
already on Dan's phone. It lands in whatever binary is submitted.

**Why:** 2.0 (5) is the first release candidate and it is in a tester's hands. A
build setting cannot be hot-fixed into an existing binary, and re-uploading to
change one line would replace the artifact under test for no gain. The honest
shape is that (6) differs from (5) by the device family plus whatever else the
submission needs, named in the submission rather than glossed.

**Shows up in:** `project.yml` on `screenshot-fixture`; nothing on `main`.

---

## D-016 · The store art is captured by script, not by hand
**2026-09-23 · Pard · DECIDED**

`scripts/screenshots.sh` builds Debug, installs to a fresh Simulator container,
overrides the status bar, and captures the six shots from launch arguments. The
scaffolding (`OptiListen/Debug/ScreenshotFixture.swift`) is `#if DEBUG` and
argument-driven, so Release, TestFlight and every ordinary Debug launch never see it.

**Why:** the Simulator has no microphone, so the listening and reflection screens
can never show a number there — and those are the screens the art exists to show.
Scripting it also makes a re-shoot cost a re-run rather than a re-take, which is
what let 09-23's three corrections (battery, green pair, spelling) land the same
day they were raised instead of being batched into one grudging pass.

**Shows up in:** `scripts/screenshots.sh`, `OptiListen/Debug/ScreenshotFixture.swift`,
`docs/store-art/6.9-inch/`.

---

## D-017 · Every art change is verified by opening the image
**2026-09-23 · Pard, after Cairn · DECIDED**

A capture is not verified by its own capture log, and a storyboard check written
by the person who captured the shots is a report on their own output.

**Why:** on 09-23 I checked six shots against the storyboard from the capture log
and called it verified. Cairn opened the images and found a charging battery in all
six, two spellings one swipe apart, and — the one that mattered — that the app
already rendered green-under on Home while I had told xian it rendered black
everywhere. Three defects, none of them visible from a log. The cost of looking is
about twenty minutes; the cost of not looking was a wrong statement to xian and a
design decision framed as a caption dispute.

**Shows up in:** practice, not code. The check is: open the PNGs.

---

## D-018 · The store art has one home, and it is `main`
**2026-09-24 · Cairn proposed, Pard decided · DECIDED**

`docs/store-art/6.9-inch/` on `main` is the only copy. No second copy anywhere,
and anything that points at the art points at a **ref**, not a bare path.

**Why:** the art was copied onto `main` on 09-23 so the rollup could link it, and
then re-shot three times on the branch — quiet battery, green pair and spelling,
the chart. `main` never followed. By this morning it was serving **generation 1 of
4**: the charging battery this page had already reported closed, the black numerals
D-009 retired, and `PRACTISING`. Anyone uploading from a `main` checkout would have
shipped every defect fixed since Tuesday, from the path that looks canonical.
Cairn caught it by comparing blob SHAs and synced at `0990e61`.

**The sync closed the window; one copy closes the cause.** Two copies of a binary
artifact drift again on the next re-shoot, and a stale binary gives no sign of
being stale — a `.png` has no version string to disagree with.

**Shows up in:** `docs/store-art/6.9-inch/` on `main`; `scripts/screenshots.sh`
writes working captures to `Screenshots/<date>/`, which is gitignored, and copying
them into `docs/store-art/` is the deliberate publish step.

---

## D-019 · `screenshot-fixture` merges to `main` today; the branch is retired
**2026-09-24 · Pard · DECIDED**

The design pass, the scaffolding, the CI workflow and the art are on `main` as of
`30881a4`. The branch is not the place any of it lives any more.

**Why now rather than at submission:** `main` and the branch had diverged 8/9 with
a split clean enough to be alarming — every `main`-only commit touched `docs/`,
every branch-only commit touched code, art or build config. So `main` carried
eleven raw system colours, three `practising` strings, an uncoloured After card,
and **no `TARGETED_DEVICE_FAMILY` line at all**, which means XcodeGen defaults it
back to `1,2` and the iPad set D-008 dropped comes back. **A build cut from `main`
this morning would have been (5) plus nothing.** Two heads where one is silently
wrong is a worse risk than merging work that is already reviewed, compiled and shot.

**What made it findable:** Cairn checked my grep-zero *against the ref* instead of
taking it. My claim was true — and true about the branch. That is the same shape as
every other defect this week: a correct statement about the wrong surface.

**The conflict, recorded because a merge resolution is a decision:** `docs/decisions.md`,
add/add, both sides having created it independently. Resolved to `main`'s copy after
diffing the common portion — zero differing lines across D-001…D-014, and `main`
additionally carried D-015/016/017. Nothing of Cairn's was lost.

**Shows up in:** merge commit `30881a4`; CI now runs on `main`, which it could not
do while the workflow lived only on a branch.

---

## D-020 · The percentage stays speech-only; the screens that show it say so
**2026-09-27 · Cairn proposed · DECIDED**

xian field-tested 2.0(5) on 2026-09-26 and reported "a bug in the percentage math":
a conversation with `user 7.2s / other 6.1s / silence 64.1s` displayed **54%**, and
his own note did the arithmetic a reader would do — "7 seconds out of 72 is it
54%?" It reads as a bug. It is not one, and changing the formula would have been
the wrong fix.

**Why it isn't a math bug.** `LiveMicSource.currentShare` was already deliberate,
already commented, and unchanged this session: `userSpeakingSeconds /
(userSpeakingSeconds + otherSpeakingSeconds)`, silence excluded on purpose so a
conversation with long pauses doesn't read as good listening. 7.2 / (7.2 + 6.1) is
54%, correctly. Nobody decided to divide by 72; the number was never claiming to.

**What's actually wrong.** `Practice.breakdownText`, added during the 09-20 field
fix, sits directly under that percentage and shows *all three* buckets — "you 0:07
· others 0:06 · quiet 1:12" — inviting exactly the division xian did by hand. Two
true, reviewed pieces of the same screen imply two different denominators. That's
the same shape this register keeps finding: not a single wrong fact, but a correct
one sitting next to another correct one that reads as its explanation.

**The fix:** `Practice.breakdownCaption` — "Percentage counts speaking time only —
the quiet time above isn't part of it." — shown wherever the breakdown is shown
(`ReflectionStep` in `PracticeLoopView.swift`, `PracticeDetail` in `HomeView.swift`).
The formula is untouched. Considered and rejected: changing the denominator to
include silence (would have thrown away the reason it's excluded, on the word of
one confused reading rather than a re-litigation of the original call); showing
two percentages (adds a number to justify a number).

**Shows up in:** `OptiListen/Models/Practice.swift` (`breakdownCaption`, and a note
on `LiveMicSource.currentShare` pointing here); both display sites named above.
Verified with `xcrun swiftc -parse` on kindbook against all four changed files —
clean. Not yet on a device; needs a TestFlight build to confirm the caption reads
right at actual list-row width before this is closed rather than just decided.

---

## D-021 · "Other" speaking time needs a minimum run before it counts
**2026-09-27 · Cairn proposed, xian leaned toward this shape · DECIDED**

xian pushed back on the D-020 fix with a sharper observation than the one that
prompted it: in the 09-26 field test that produced `other 0:06`, no second person
was actually speaking at all. That six seconds was something in the room, not
someone in the conversation. Worth asking directly: **could OptiListen only ever
work listening to a video call, or would a concurrent phone call on the same
device work too?** Answer, from reading `LiveMicSource` rather than guessing:
neither is quite right. The mic is the phone's own built-in mic, never a call
tap; a real phone call is an `AVAudioSession` interruption and `observeInterruptions()`
stops capture the moment one starts. A video/VoIP call on the same device that
keeps the session foregrounded is untested this session — the app doesn't
distinguish it from any other room-audio case. **So: not a display defect, as
xian concluded — a real classification gap**, distinct from D-020's.

**The gap:** `classify(_:)` has no voice-activity detection and never claimed to.
Every 0.1s buffer in the threshold/floor gap was "other," regardless of whether
it lasted one buffer or thirty — a door, a cough, a page turn, and a real second
voice were indistinguishable.

**The fix:** a minimum-run gate on the "other" bucket only. A moderate-volume
stretch must hold for `otherMinRunBuffers` (3 buffers, 0.3s) before it counts as
`otherSpeakingSeconds`; a shorter stretch folds into `silenceSeconds` instead,
via `resolvePendingOtherRun()`, called on every non-"other" buffer and on `stop()`
so a run still building when capture ends doesn't vanish from `observedDuration`
uncounted. Two diagnostics counters (`discardedOtherRuns`, `discardedOtherSeconds`)
surface what got folded, in the same log a tester can already paste. The "user"
bucket is untouched — no evidence yet that transient noise misreads as *you*, and
this file's own rule is to fix problems it has, not problems it might have.

**Not done, and why:** real voice-activity detection (pitch, formants, anything
beyond loudness) — a much larger feature than this field report calls for, and
this project's standing pattern is the smallest fix that answers the actual
evidence. 0.3s is a first estimate, same epistemic status as the original 12/16 dB
calibration bars: it wants a field test with a real second speaker before anyone
treats it as tuned.

**Shows up in:** `OptiListen/Sources/LiveMicSource.swift` (`classify(_:)`,
`resolvePendingOtherRun()`, `otherMinRunBuffers`, `discardedOtherRuns/Seconds`,
a new class-doc addendum). `CURRENT_PROJECT_VERSION` bumped "6" → "7". No UI
changes — `PracticeLoopView.swift` and `Practice.swift` already read the resolved
totals after `stop()`, so this is invisible to callers. Verified with `xcrun
swiftc -parse` on kindbook; not yet on a device with a real second speaker.

## D-022 · Site copy patch stands even though 1.x needed headphones
**2026-09-27 · xian decided · DECIDED**

`docs/site-audit-2026-09-27.md` flagged an open question: the site's "Try the
Free App" button still ships 1.x, and the Tier 1 copy patch (`5087264`) says the
phone listens to the room, no headphones — true for 2.0, unconfirmed for 1.x.
**xian confirmed 1.x was in fact designed for headphones.** So the patched copy
is, briefly, wrong about the app that button actually delivers.

**Left as-is anyway, on xian's call:** there are no active or new users of 1.x
right now, so a short window of copy/app mismatch on a page nobody's reading
costs nothing. No further change to the site or the app-download gating.

**Shows up in:** closes the open question in `docs/site-audit-2026-09-27.md`.
Nothing to revert if 2.0 slips — the copy becomes true the moment 2.0 ships,
which is the point of writing it that way in the first place.

## D-023 · The first conversation passes through calibration; no calibration, no number
**2026-10-06 · xian agreed the flow should steer; Cairn chose this shape · DECIDED, not yet run on a device**

Dan's first run of 2.0 (7), relayed verbatim by Janus on 10-06
(`docs/mail/janus-to-cairn-cc-xian-dans-feedback-on-build-7-2026-10-06.md`): he
liked the design, talked alone into the phone, and "the percentage was going
down." He had not calibrated: "I think the flow didn't steer me that way." xian:
"i agree it should steer you!"

**What the code did, read from 2.0 (7)'s source.** The only door to calibration
was an icon-only toolbar button on Home. A practice started without it ran
against `Calibration.unavailable` (user −20 dBFS, ambient −50), which puts the
you/other line at −36.5 dBFS and the silence floor at −47. Any 0.1 s stretch of
sound between those two levels that lasts 0.3 s counts as someone else talking.
The listening screen did say "Not calibrated, so this number is against
placeholder thresholds", in a grey footnote under a 100-point number.

**What is inferred, not measured.** That Dan's own voice fell into that band
often enough to pull his share down. It fits what he described and the
thresholds allow it; no diagnostics log from his run exists, so it is a
mechanism that explains the report, not a reading of it.

**The change.**
1. Tapping Start with headphones off and no calibration this launch opens
   calibration first, with a line saying why and a Skip. Finishing, skipping or
   failing all lead on to the conversation.
2. With no calibration the listening screen shows the practice line and "No
   reading this time", the same screen headphones get, and nothing is stored as
   a measurement. A number against placeholder thresholds is no longer shown
   anywhere.
3. The ceiling caption on the Before screen read "Share of the conversation you
   intend to spend talking", while every reading is a share of the *talking*.
   It now reads "Share of the talking you intend to do. Quiet stretches don't
   count either way."

**Not done, and why.** Calibration is still not persisted, so the steer happens
once per launch; whether a calibration should outlive the room it was taken in
is a real question and this entry does not answer it. `Calibration.unavailable`
still exists and `classify(_:)` still runs against it; nothing reads the result.
Telling two voices in one room apart is not attempted: the classifier sorts by
loudness, so it separates near from far and nothing else.

**Shows up in:** `OptiListen/Views/PracticeLoopView.swift` (`begin()`,
`startListening()`, the listening and capture guards, the ceiling caption),
`OptiListen/Views/CalibrationView.swift` (`isFirstRun`).
`CURRENT_PROJECT_VERSION` "7" → "8" in `project.yml`; the Xcode project is
regenerated at build time on Amber. Syntax-checked only on kindbook.
