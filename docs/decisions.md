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

## D-014 · Mac and Apple Vision availability — OPEN
**2026-09-23 · raised by Cairn · OPEN, xian's**

The live listing shows 1.1 available on Mac (Apple silicon) and Apple Vision.
[INFERRED] that is the per-app App Store Connect availability setting, so 2.0
inherits it unless unchecked. 2.0 is portrait-only, opens the microphone on launch,
and has run on exactly one iPhone.

**It is a checkbox**, in App Store Connect, which is behind xian@pobox.com.

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
