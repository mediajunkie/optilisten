# OptiListen — what needs xian

**Maintained by:** Cairn · **Updated:** 2026-09-25 (rev 37) · **Deadline:** 2026-11-24 (60 days · day 30 of 90 — from the 08-26 notice, the only place the date exists; App Store Connect's API has no removal-date field. No 2.0 version record exists at all — read from the API on 09-21, not inferred)

Canonical state. Janus may summarize this into the cross-project meta-rollup.
Rendered for xian as an artifact — https://claude.ai/code/artifact/54087bd3-f172-494f-b79b-49d3406f5215
(republish that same URL rather than creating a new one). This file is the source; the artifact follows it.
The artifact's HTML source lives beside this file at `docs/attention.html`.

> **rev 37: a quiet pass — the clocks rolled and nothing else did.**
> **No mail for Cairn since Pard's 09-24 memo, which rev 36 answered**, and nothing new in either
> mailbox this morning. **Apple mail re-read this pass: still nothing on OptiListen** — the newest
> is the same 2.0 (5) processing pair of 2026-09-21 15:36 UTC, no review state, no removal or App
> Store Improvement mail, no crash submission. **2026-11-24 is now day 30 of 90 and 60 days out**,
> and it is still the 08-26 screenshot, never re-read from Apple.
>
> **The one number that moved is the one nobody wants moving.** 2.0 (5) has been installable on
> xian's phone and on Dan's for **four days** with no report in either direction, and that channel
> cannot say whether either of them has opened it. Item 1 is unchanged and is not being re-raised —
> it stays on the page because only xian can close it.
>
> **Still open and still Pard's:** `build.yml` triggers on `branches: [main, screenshot-fixture]`, a
> branch retired on the 24th. No CI run since `36025726212` (success, on `main`); working tree clean
> at `dbb944c`.

> **rev 36: the merge landed, and `main` now answers "does it compile" by itself.**
> **Everything rev 35 raised is closed, and I checked each against the thing rather than against
> Pard's report of it.** `git merge-base --is-ancestor 30881a4 HEAD` returns **YES**;
> `TARGETED_DEVICE_FAMILY` present, `practising` **0**, `build.yml` / `screenshots.sh` /
> `ScreenshotFixture.swift` all resolve, register unbroken **D-001 … D-019**. **All six store-art
> PNGs are blob-identical between `main` and `screenshot-fixture`** — the generation that came home
> is the generation that was shot, not a fourth copy. `screenshot-fixture` is retired (D-019) and
> D-018 gives the art one home. **A (6) cut from `main` today is the real thing.**
>
> **The CI runner is green on `main` and that retires the project's oldest standing risk.**
> `gh run list`: run `36025726212`, **success**, 1m20s, push to `main`, 16:12 UTC — Pard's merge
> commit — with the previous `startup_failure` sitting directly above it in the same list. For
> eleven days "does this compile" was a question only one machine could answer and only while it
> was awake. It now answers itself on every push, for both agents, whether or not Amber is on.
> **This project has shipped uncompiled changes twice; it cannot do so silently again.**
>
> **The CI failure cause is worth more than the fix.** Every run had been dying at
> `startup_failure` before a step executed. `yaml.safe_load` said OK, `actionlint` said OK, **and
> both were right — the file is valid.** This repo's Actions policy is `allowed_actions:
> local_only`, so `actions/checkout@v4` is refused at startup, and **neither validator reads a
> policy.** Pard fixed it by dropping the dependency rather than widening the policy, on the
> grounds that the policy is somebody's deliberate choice on a public repo and a build convenience
> is a poor reason to widen what may execute. **Fourth member of the class that has now cost this
> project four times: the bundle ID, the `Info.plist` version string, the iOS minimum, and now a
> repo policy — things no checker in the loop looks at and the runtime does.**
>
> **The "level below D-010" is bounded, and the answer is that there is no sweep to run.** Pard
> closed yesterday's chart bug by noting the palette has a level my raw-colour grep cannot reach.
> [EVIDENCED] `main` carries **31 bare hierarchical styles** — `.secondary` ×27, `.tertiary` ×4,
> across `CalibrationView` 7 / `HomeView` 13 / `PracticeLoopView` 11 — every one in the syntactic
> position that bit the chart. [EVIDENCED] there is **exactly one `Chart`** in the app, and it is
> the one already fixed; [EVIDENCED] every `.foregroundStyle(Theme.*)` sits on a **leaf** that is a
> *sibling* of the `.secondary` ones rather than a container wrapping them, so nothing rebases the
> hierarchy anywhere else. [INFERRED, and marked because I cannot run a compiler] `.tint` becomes
> the current foreground style **inside the Chart plot and not for ordinary `Text`**.
>
> **And the art corroborates it, which is the part that isn't inference.** I sampled all six
> shipped PNGs pixel-wise: **chromatic-green pixels 217–1,639 per shot against 4,998–42,391
> near-achromatic text pixels.** If `.secondary` were inheriting the tint those columns would be
> reversed. Dominant green is **(61,107,84)** — `Theme.within` light, to the integer. Three things
> fall out of the bounding boxes and all three are good news: **D-009 renders correctly** (shot-3
> numeral and caption green at (472,1106)–(856,1260) and (556,1398)–(762,1432) with *zero* amber in
> the shot; shot-4 the same two boxes in amber with no green near them — same geometry, opposite
> tokens, one meaning); **D-011's fix is visible in the shipped bytes** (shot-6's only chart green
> is a 24×24 *point* at (1140,1466), no green stroke anywhere in the plot); and the rest of the
> green is **controls**, identical in shots 3 and 4 regardless of state, which is what `.tint` is
> for. **Not covered, stated rather than glossed:** `CalibrationView` is on no screen in the store
> art, so its 7 sites have the structural argument and no pixel corroboration.
>
> **One loose end, trivial and exactly on theme.** `build.yml` still triggers on
> `branches: [main, screenshot-fixture]` — a branch retired this morning. Harmless, one line,
> Pard's. Noted because **a name outliving its referent** is the subject of both of yesterday's
> findings.
>
> **Apple mail re-read this pass:** nothing new on OptiListen. Newest is still the 2.0 (5)
> processing pair of 2026-09-21 15:36 UTC — no review state, no removal or App Store Improvement
> mail, no crash submission. **The build has now been installable for three days and eight hours
> with no report in either direction**, and that channel cannot say whether anyone has opened it.
> **The 2026-11-24 date is still the 08-26 screenshot and has never been re-read from Apple.**

> **rev 35: the compile and the grep were true — of a branch `main` has none of.**
> **Pard delivered all three asks and I checked each rather than taking it.** `6cccc56` BUILD
> SUCCEEDED on Amber, the raw-colour grep returns zero, all six shots re-shot at `b992de6`,
> D-015/D-016/D-017 in the register. Every one of those is true. **Every one of them is true about
> `screenshot-fixture`.**
>
> **`git merge-base --is-ancestor 6cccc56 origin/main` returns NO.** The two have diverged 7/7 and
> the split is unusually clean: **every main-only commit touches only `docs/`** — attention,
> decisions, mail — **and every branch-only commit touches code, art or build config.** So `main`
> today still carries eleven raw system colours (`CalibrationView` 5, `HomeView` 2,
> `PracticeLoopView` 4), three `practising` strings, the After card with no colour on it, **no
> `TARGETED_DEVICE_FAMILY` line at all** — so XcodeGen defaults it back to 1,2 and the iPad set we
> just decided to drop returns — no screenshot scaffolding, no CI workflow, and no D-011.
> **(5) was cut from `main` and was right to be; the design pass did not exist yet. (6) cut from
> `main` today would be (5) plus nothing at all.**
>
> **Nothing records when the branch merges.** D-015 notes the device-family setting is on the
> branch and not on `main`, so the fact is known — but the merge itself appears in no decision and
> on no page, and a lane whose first step is unrecorded is the lane this project has twice paid
> for. Raised to Pard as a step to name rather than a shared assumption. **Not yours** — the build
> lane is his.
>
> **And the sharper one, which is mine.** My rev 33 commit `c6de4ac` copied the six shots onto
> `main` so this page could point at them. Pard then re-shot three times — quiet battery, the green
> pair and PRACTICING, then the chart — and **`main` never followed.** I compared blob SHAs rather
> than paths: all six differed, and `main`'s `shot-3` was `0b4973f`'s blob. **`main` was holding
> generation 1 of 4 — the original capture, still showing the charging battery this page reported
> CLOSED on the 23rd, and the black numerals and PRACTISING that D-009 and D-012 retired.** Anyone
> uploading art from a `main` checkout uploads every defect we have fixed since Tuesday, from a
> path that looks canonical while doing it. **Synced at `0990e61`** — the six are now bit-identical
> to `screenshot-fixture@129dd20`, dimensions re-checked at 1320x2868. That closes today's window
> and not the cause: two copies of a binary artifact drift again at the next re-shoot. Proposed to
> Pard as **D-018, the store art has one home**.
>
> **The CI runner Pard built today is not guarding `main` yet either.** Its triggers name
> `[main, screenshot-fixture]`, but GitHub reads workflows from the branch being pushed and
> `.github/workflows/build.yml` does not exist on `main` — so a push to `main` today runs nothing.
> Not a defect in the file; a consequence of where it lives, and a third reason the merge is a step
> rather than a formality.
>
> **D-011 is closed, and the bug it exposed is the best thing in the day's work.** Pard built the
> neutral line with per-point colour at `129dd20` — then opened the image and found the line
> rendering *moss*. `.primary` in a `ShapeStyle` position is `HierarchicalShapeStyle.primary`,
> which resolves through the app's `.tint(Theme.within)`, so a ceiling-crossing series drew
> entirely green: **"within" asserted for every point — exactly what D-011 exists to prevent,
> arrived at by inheritance rather than by anyone choosing it.** It compiles clean either way and
> **D-010's raw-colour grep cannot see it, because nothing is spelled wrong.** A level below the
> one I swept, found only by opening the picture — D-017 paying for itself the day after he wrote
> it against himself.
>
> **Apple mail re-read this pass:** nothing new on OptiListen since the 2.0 (5) processing pair of
> 2026-09-21 15:36 UTC. No review state, no removal or App Store Improvement mail, no crash
> submission. **The 2026-11-24 date is still the 08-26 screenshot and has never been re-read from
> Apple.**

> **rev 34: green, and the ruling came with a standard that made it a sweep rather than two lines.**
> **xian ruled on item 4 and attached a bar:** *"yes green and yes it's critical for things to be
> consistent and for us not to cut corners. design decisions need to be called and tracked too."*
> Both halves acted on in the same pass.
>
> **D-009, the ruling itself.** The `within`/`over` pair now applies on every screen that says
> which side of the ceiling you are on — the live numeral and its caption, **the After card's
> numeral and caption, which carried no colour at all** and which nobody had looked at, alongside
> the Home list that already did it. One fact, one rendering. That is the smaller half.
>
> **D-010, what the sweep turned up: eleven raw system colours, now retired.** Six `.orange`
> warnings, a `.green` checkmark, a `.red` failure, a `.blue` step prompt. **SwiftUI's `.orange`
> is visibly brighter than `Theme.over`** — (1.0, 0.58, 0.0) against (0.72, 0.42, 0.16) — so the
> app was already showing *two different ambers meaning two different things*, and the difference
> was an accident of which colour someone reached for. Two calls inside that: `Theme.over` now
> deliberately carries both "over your ceiling" and "this reading is not trustworthy," because
> both say *the number needs your attention*; and **there is no red in this app any more**, since
> a calibration that did not run is not an emergency either. `Theme.swift`'s doc comment now says
> all of it, so the spec matches the code — which is this whole episode's lesson.
>
> **D-012 landed too:** `practising` → `practicing`, three strings. I called it yesterday and had
> not shipped it; "don't cut corners" is the same instruction.
>
> **One thing deliberately NOT done, and recorded as open rather than quietly decided.** The Home
> chart's trend line runs through points on both sides of the ceiling, so **no single colour for
> that series can be right.** My global swap tokenised it to `Theme.over` and I backed that out —
> it would have asserted "over ceiling" for every point including the ones under it, a *new*
> inconsistency introduced while fixing one. Neutral for now. The right answer is per-point
> colour, which needs the Chart body and a compiler rather than a colour literal, and kindbook has
> no SDK. **D-011, Pard's, no hurry.**
>
> **`docs/decisions.md` is new, and it is the second half of what you asked for.** Design
> decisions were being made and then living only in commit messages, memos and this page's prose.
> **D-004 is the proof: the colour pair was decided on 09-21 and written into `Theme.swift`, and
> only one of the three screens that needed it ever got it, with nothing recording that it was
> meant to be universal. The decision existed; the tracking did not.** Fourteen entries,
> backfilled to D-001, each with the decider, the why, where it shows up so it can be checked
> rather than believed, and a status. **This page says what is happening; that one says what was
> decided.**
>
> **Parse-clean on kindbook and that is all it means** — `swiftc -parse`, syntax only, no SDK, no
> type checking. Everything changed is a colour literal or a string so I expect it clean, but
> Amber is the check. Shots 3 and 5 need re-shooting for the green; Pard had already re-shot all
> six with the quiet battery before I got here, so that defect is closed.
>
> **Apple mail re-read this pass:** nothing new since the 2.0 (5) processing pair of 2026-09-21
> 15:36 UTC. No review state, no removal or App Store Improvement mail, no crash submission.

> **rev 33: the screenshots exist, and looking at them found something reading the code did not.**
> **Pard delivered all six iPhone shots today and they are correct.** `origin/screenshot-fixture`
> at `0b4973f`: six PNGs in `docs/store-art/6.9-inch/`, and I read the dimensions myself with
> `sips` rather than from his capture log — **all six are 1320 x 2868**, portrait, which is the
> 6.9-inch size the listing requires. `TARGETED_DEVICE_FAMILY: "1"` is on the same branch with the
> evidence in the comment. The fixture is Debug-only and argument-driven, so a Release build and
> TestFlight never see it. Nothing is on `main`; 2.0 (5) on your phone and Dan's is untouched.
>
> **Then I pulled the six images into my own environment and looked at them, which is the step
> nobody had taken.** Pard's check of the art against my storyboard is a report on his own output,
> and that exact shape has cost this project three times this month. It was worth twenty minutes.
>
> **The one deviation Pard escalated turns out to go the other way, and it is now a decision for
> you.** He reported that my caption said green-under/amber-over and the app does black-under. True
> of the Listening screen — `PracticeLoopView.swift:214`, `overGoal ? Theme.over : .primary`. **But
> shot 6 shows an under-ceiling number in green**, because `HomeView.swift:168` renders the Recent
> list as `practice.metGoal == true ? Theme.within : Theme.over`. Shot 5's After card is black
> again. **Three screens, one meaning, two different answers — the inconsistency is inside the app,
> not between the app and my caption.** And the tiebreak is already written down in `Theme.swift`,
> in the design pass's own words: *"`within` and `over` are a semantic pair, not decoration. Green
> below your ceiling and amber above it says which side of your own intention you are on without
> needing a label, which matters because the person reading it is mid-conversation and not really
> reading."* **Mid-conversation is the Listening screen** — the one view that does not implement it.
> So this is not a tint invented to flatter a screenshot; it is the design pass not having landed in
> its own primary target. New item 4. Two lines of code, and it forces a re-shoot of shots 3 and 5,
> which is scripted and therefore cheap.
>
> **Three defects in the art, found by looking, all cheap and none of them blocking.** (1) **Every
> one of the six shots has a charging battery** — green cell, lightning bolt. Pard's script passes
> `--batteryState charged`, which is the value that draws the bolt; the quiet full battery Apple's
> own marketing shots use is `--batteryState unplugged --batteryLevel 100`. One word, one re-run.
> (2) **The app cannot spell "practising."** Shots 3 and 4 say `PRACTISING`; shot 2 asks *"What are
> you practicing?"* and shot 5 says *"You were practicing:"*. Both spellings are in the store art
> one swipe apart, where a reviewer sees them. Three strings. **Mine, it is copy, and I am calling
> it "practicing"** — US spelling, US listing, US seller. (3) **Shot 1 is the weakest image in the
> set and is currently first.** Two-thirds empty frame — an honest picture of the empty state, but
> the App Store shows the first one or two without a swipe and this one sells nothing. Shot 6
> carries the whole argument in one frame. **I want to lead with 6, then 4, then 2.** Content call,
> so mine, but flagged rather than done quietly. No re-shoot — it is the upload order.
>
> **Privacy: Pard found the cause and the fix is a build step.** `optilisten-site` is a React SPA on
> GitHub Pages, which serves a real file only for `/`; the `spa-github-pages` shim in `404.html`
> recovers every deep route client-side, which is exactly the 404 rev 32 recorded. Emitting a static
> `privacy/index.html` in a `postbuild` step makes the status code honest while the router still
> renders the page. One `package.json` line and one `npm run deploy` — **your hand, and the policy's
> wording is yours too.** Still not a blocker.
>
> **Apple mail re-read this pass:** nothing new. The 2.0 (5) processing pair of 2026-09-21 15:36 UTC
> is still the newest OptiListen mail — no review state, no removal or App Store Improvement mail,
> no crash submission. **The build has now been installable for about two days and eight hours with
> no report in either direction**, and that channel still cannot say whether anyone has opened it.

> **rev 32: the iPad question is answered, and the answer removes work rather than adding it.**
> **1.1 shipped iPhone-only — evidenced three ways, without the clone everyone assumed was needed.**
> Pard checked Amber and reported honestly that `AustinWood/listenup-mobile` is not cloned there. It
> did not need to be: `gh` on kindbook already has read access to it, and one API call returns one
> file. The 1.x `project.pbxproj` sets **no `TARGETED_DEVICE_FAMILY` at all**, and its `Info.plist`
> carries no `UIDeviceFamily`. The live App Store page's Compatibility block, read today, lists
> **iPhone, iPod touch, Mac and Apple Vision — and no iPad.** The iTunes lookup returns **four
> iPhone screenshots and zero iPad screenshots**, which App Store Connect would not have accepted
> from an iPad-capable app.
>
> **So nobody owns OptiListen on an iPad, and dropping iPad takes nothing from anyone** — which was
> the one thing I said I had to establish before recommending it. 2.0 goes to
> `TARGETED_DEVICE_FAMILY: "1"`, the required iPad 13" screenshot set disappears, and an untested
> device family comes off an app that has already been rejected once. Sent to Pard this morning
> ahead of his fixture cycle, so today's screenshot work is scoped to six iPhone shots rather than
> two sets. The evidence is mine; the edit and the build sequencing are his.
>
> **One new surface, and it is not one we chose.** The same Compatibility block lists the app as
> available on **Mac (Apple silicon)** and **Apple Vision**. [INFERRED] that is the App Store
> Connect availability setting, which is per-app rather than per-build, so 2.0 inherits it unless
> somebody unchecks it. 2.0 is portrait-only, opens the microphone on launch, and has been run on
> exactly one iPhone. That is the new item 3(a), and it is a checkbox.
>
> **And the privacy page is both better and worse than this page has been saying.** It renders, it
> is substantive, and its own date line reads *"This policy is effective as of 4 July 2022. Last
> updated: 4 July 2022"* — so "not touched since February 2023" was the repo's commit date rather
> than the document's, and that was my error, carried here for two revisions. But
> `optilisten.com/privacy` and `/privacy/` both return **HTTP 404**: GitHub Pages serves the
> `spa-github-pages` redirect shim in the body, so a browser with JavaScript recovers and renders
> the policy, while anything reading the status code sees a dead link. **I am not calling it a
> blocker** — 1.x cleared review twice on this exact site. The policy also never mentions the
> microphone.

> **rev 30: Dan already had it, and the thing that stops the clock is now measured rather than guessed.**
> **Item 2 closes without costing you anything.** Pard read the beta-tester list out of App Store
> Connect: Dan is in the internal **DinP** group with state **INSTALLED** — he has TestFlight, he has
> accepted, and internal groups receive every processed build automatically. **2.0 (5) has been on
> Dan's phone since 15:36 UTC on the 21st.** There is no provisioning job to do. What is left is one
> sentence to him, which you said you would send and which can wait until he is off the road. My
> guess was wrong, in the direction I flagged as likely — I had expected him to be missing, said so,
> and asked for it to be read rather than believed.
>
> **The version-record reading is now evidence.** `GET /v1/apps/1593948410/appStoreVersions`, read
> 09-21: exactly two records, **1.1 `READY_FOR_SALE`** and **1.0 `REPLACED_WITH_NEW_VERSION`**.
> Nothing from the 2.0 line at all. Five builds have cleared processing and TestFlight and **none of
> them has a version record to attach to** — App Review has not been entered, and 24 November has
> not moved. Item 3 now stands on a measurement instead of on my inference.
>
> **Checked from the outside too, because it is a different surface.** The public listing is live:
> version **1.1**, updated **07/19/2023**, seller Christian Crumlish. Two independent records that
> agree, rather than one record read twice — and it re-confirms that the shipped 1.x is 1.1.
>
> **One thing the listing turned up, swept and clear.** It reads *"Requires iOS 11.0 or later"*;
> 2.0 requires iOS 17. Submitting raises the published minimum by six major versions. The 09-07
> analytics already answer it — every download since 2024 is on 17+ — so nobody is cut off, and
> Apple permits the raise. Recorded because it is the third member of a class that has cost us twice
> (the bundle ID, then the Info.plist version string): **metadata the compiler never checks and the
> submission does.**
>
> **Apple mail re-read this pass:** nothing since the 2.0 (5) processing pair of 09-21 15:36 UTC. No
> review state, no removal or Improvement mail, **and no crash submission**. That last one is not
> reassurance — the channel cannot say whether the build has been run, and 2.0 (3) already proved a
> crash can file no artifact at all. **The build has been installable for about twenty-one hours
> with no report in either direction.**

> **rev 29: you said go, Pard built it, and Apple says it is on your phone.**
> **2.0 (5) is testable.** Pard uploaded at 08:35 PT — delivery `3d55569b`, built from `main` at
> `de7f997`, version and bundle ID read back out of the archive and the IPA rather than off an exit
> code, no validator warnings. **Apple's own mail closes the loop 82 seconds later:** *"Version 2.0
> (5) for OptiListen has completed processing"* and *"OptiListen 2.0 (5) for iOS is now available to
> test"*, both stamped 2026-09-21 15:36 UTC. It has been installable for about seven and a half
> hours. That is verified from Apple, not from a report of Apple.
>
> **Rev 28's one item is closed.** "Written, unbuilt, waiting on one word" lasted about eleven
> hours. Nothing on this page is now waiting on Pard, on me, or on a build — every live item is
> either the field test or a decision only you can make.
>
> **The thing five builds have not touched is the date.** 2.0 (1) through (5) have all cleared
> *processing*; none has ever entered *App Review*, and App Review is the only event Apple's notice
> says stops the removal. That is not news — it has been the standing correction since rev 22 — but
> with the build finally in hand it is the only item left with a deadline attached, and it has never
> had a date of its own. Hence item 3, which asks you for a date rather than for an action.
>
> **Apple mail re-read this pass:** the 2.0 (5) processing pair is the newest OptiListen mail that
> exists. No review state, no removal or App Store Improvement mail. Same limit as always — that
> channel speaks to the clock and to nothing else, and in particular it cannot tell anyone whether
> the build has been run.

> **rev 28: the release candidate is written, unbuilt, and waiting on one word from you.**
> Pard read both of last night's memos in order, acted on the second only, and **built nothing from
> the superseded tree** — Amber was rebooting through that window (macOS 26.7, fleet resume), so
> there is nothing to discard. His stated condition for building: current `main`, same build number
> 5, the design pass included, `docs/design-pass-2026-09-21.md` read first. He is holding because he
> read the scheduling as yours — *"xian's call, not tonight"* — and that was 21:12 PT on the 20th.
>
> **Nothing else moved overnight.** No Apple mail about OptiListen since the 2.0 (4) processing
> notice of 2026-09-17 00:12 UTC: no review state, no new build, no removal or App Store Improvement
> mail. Four builds have cleared processing, zero have entered review, so 24 November stands where
> it stood. That channel is evidence about the clock and about nothing else — it cannot say whether
> a build has been run.
>
> **This file was the stale half this time, not the page.** The rendered rollup has said since last
> night that nothing is waiting on you; this file still carried "run 2.0 (4)" in Needs you, which you
> did on the 20th. The usual split runs the other way. Fixed here; the two are level again.

> **rev 27: 2.0 (5) is the release candidate, and it goes to Dan as well as to you.**
> Four field fixes plus a ratified six-item design pass, all on `main`, all parse-clean, Pard's to
> build. He had not started (5) when the design work landed, so it folds into the same build number.
>
> **The design reframe, recorded in `docs/design-pass-2026-09-21.md`: the app is not too plain, it
> is undesigned.** Every control sat where SwiftUI put it, in system blue, at default weight. Plain
> is the right answer for an instrument you set face-up and stop looking at, but it has to be a
> decision rather than an absence. Landed: one accent pair (moss inside your intention, amber over
> the ceiling, semantic rather than decorative) applied once at the app root; the End button off
> filled destructive red, which was the loudest element on a screen about listening quietly; the
> number settling on the existing one-second tick instead of redrawing every 100 ms; two haptics,
> at the first ceiling crossing and at the loop closing, because the phone is face-up and unwatched;
> the Home counter animating on change; and no "0" in 52-point type on first launch.
>
> **Not a detour from 24 November:** the listing needs new screenshots, and screenshots of an
> undesigned app are what a prospective user sees.
>
> **What the build is for, stated so the test is deliberate.** The calibration thresholds in it are
> mine, estimated from one field run: `isUsable` 8 dB → 12, silence floor `ambient - 6` →
> `ambient + 3`. Your 09-20 outdoor calibration measured a 9.7 dB gap, so **under this build that
> same session produces no number at all** and says your voice and the room are too close together.
> Intended, and the thing under test. One indoor run and one outdoor run answers it. If indoors also
> refuses, the bar is wrong and I would rather find that out in a day than defend it.

---

## Needs you

| # | Item | Why it's yours | Cost | Blocking |
|---|---|---|---|---|
| 1 | **Run 2.0 (5) — once indoors, once outdoors.** It has been on your phone four days. | The calibration bar in this build is mine, estimated from your single 09-20 run: `isUsable` 8 dB → 12, floor `ambient - 6` → `ambient + 3`. **Your 09-20 outdoor session measured a 9.7 dB gap, so under this build it produces no number at all** and tells you your voice and the room are too close together. Intended, and exactly the thing under test. If indoors also refuses, the bar is wrong and I would rather learn that in a day than defend it. **Nothing on our side can see whether you have run it** — the Apple channel carries processing and review mail only — so this stays on the page until you say. | ~10 min | the thresholds, the listing screenshots, and Dan's first impression |
| 2 | **Tell Dan it is already on his phone.** No setup needed — he is provisioned and installed. | Pard read the tester list out of App Store Connect on the 21st: Dan is in the internal **DinP** group, state **INSTALLED**, four testers on the app in total. Internal groups receive every processed build automatically, so **the two-minute App Store Connect job this item used to describe does not exist.** He said yes on 09-16 and has been able to open 2.0 (5) since 15:36 UTC on the 21st without knowing it is there. He is traveling, so this is not urgent — it is one sentence whenever you reach him. | ~1 min | Dan's first contact with the product |
| 3 | **Two reads and two decisions the store-content draft cannot make from here.** All in App Store Connect or on the marketing site. | `docs/store-content-2.0.md` is drafted and waiting. **The iPad question that used to be (a) is closed, and it closed as "drop it"** — 1.1 shipped iPhone-only, evidenced three ways on 09-23, so dropping iPad costs no existing customer anything. That recommendation is in Pard's inbox and the edit is his. What is left for you: **(a) Uncheck — or deliberately keep — Mac and Apple Vision.** The live Compatibility block lists 1.1 as available on both. [INFERRED] that is a per-app availability setting 2.0 inherits; 2.0 is portrait-only, opens the microphone on launch, and has run on one iPhone. **(b) The keyword field and the secondary category** are not public and must be read before being overwritten. **(c) The privacy URL returns HTTP 404** behind a JavaScript shim — the policy renders for a browser and is dated 4 July 2022, but the link in the listing is a 404 to anything reading status codes, and the policy never mentions the microphone. Not a blocker: 1.x cleared review twice on this site. **(d) Sign off on the subtitle and description**, or redirect them — the current description's first sentence has to go either way. | ~15 min | the screenshot shoot, and nothing else yet |
| ~ | **[CLOSED 09-24 — you ruled green.]** Was: rule on one colour. Two screens already disagree. | Not a taste question and not a screenshot's request. `HomeView.swift:168` already renders an under-ceiling number in **moss** (visible in shot 6's Recent list); `PracticeLoopView.swift:214` and the After card leave it **black**. `Theme.swift`'s own doc comment says the green/amber pair exists *"because the person reading it is mid-conversation and not really reading"* — which describes the Listening screen, the one place it is not applied. **So the question is which of two screens is right, with the design pass's stated intent on the record.** Say go and it is two lines plus a re-shoot of shots 3 and 5 (scripted, minutes); say leave it and I rewrite two captions instead. Either answer unblocks the art. | ~1 min | the screenshot set, and the shot-3/5 re-shoot |
| — | **Done since the last pass: you said go, and it shipped.** One line to Pard this morning; he built from current `main`, regenerated the project at build 5, verified version, bundle ID and signing out of the archive and the IPA, and uploaded clean — previously items 1 and 2 on this page. Before that, **you ran 2.0 (4)** on the 20th. The report was the most useful artifact of the month — four findings, all four fixed, and the diagnostics panel turned "it may have treated bird calls as talking" into `silence 0.0` over 100.8 seconds, which is a measurement rather than an impression. | One thing still open to overrule if you want to: the brochure's footer now reads "drafted by Claude for Christian," and every first-person claim that wasn't your own action or decision is gone. Dan's markup flagged that as its most serious item. Change the byline if you'd rather handle the disclosure differently. | — | — |

## Dan's answer

**Good doc, good plan, and he volunteered to test the app** ("happy to try for the practice app if
it's not too much of a hassle"). He also ran his own `no-ai-tropes` skill over the brochure twice and
sent back **83 comments, 90 deletions, 20 em dashes, on about 1,400 words**, with the note that he
gets "itchy" reading AI-speak. The content was fine. The prose nearly stopped him reading it.

**Ten of the 83 are not about phrasing.** The document was agent-written, in the first person, signed
with your name, containing claims about what you had done and thought that you had neither done nor
said. That is the same failure as this month's others, one layer out: reporting our own output as a
reading of the world. Written up as `mediajunkie/docs/convention-plain-language.md` and sent to
Themis for the shared methodology, per your instruction.

Brochure republished as v2 with every edit applied. Dan's skill and the full markup archived at
`docs/reference/`.

## A live strategic option, not yet a recommendation

**Live capture is not required for App Store compliance and is not required for the product
argument.** The loop closes on intention + reflection, `ManualSource` exists, and
`Practice.isComplete` ignores measurement by design. So there is a shippable build with the
microphone behind a flag and the manual number as the only path: Apple satisfied, capture off the
critical path. It trades a working prototype in Dan's hands for certainty against 24 November.
**63 days and three failed builds is the reason it's on the table now rather than discovered in
November.**

**Where it stands (rev 24):** you ranked it on 09-17, item 6: *"Let's prep the fallback build and have
it ready if we run short of time."* Pard preps and holds it. Whether it ships is your decision, and
nothing is asking you for it yet.

## Resolved this pass

- **The merge is done and every rev-35 alarm closes with it.** [EVIDENCED] `30881a4` is an
  ancestor of `main`; device family, spelling, scaffolding, CI and D-011 all present on `main`;
  register unbroken D-001…D-019. **All six art PNGs blob-identical between `main` and the retired
  branch** — checked by SHA, not by path, which is the check that caught the drift in the first
  place.
- **`main` now compiles on every push, and nobody has to be awake for it.** Run `36025726212`,
  success, 1m20s. The oldest standing risk on this page — a compile answer that lived on one
  machine — is retired. The runner does not sign, archive or upload, deliberately; a green check
  here is not "ready to submit."
- **The CI cause was a repo Actions policy, not the file.** `allowed_actions: local_only` refuses
  `actions/checkout@v4` at startup; `yaml.safe_load` and `actionlint` both passed and both were
  correct. Fixed by removing the dependency rather than loosening the policy. **Fourth member of
  the metadata/policy class** after the bundle ID, the `Info.plist` version string and the iOS
  minimum.
- **D-018 and D-019 are in the register** — one home for the art, and the merge itself recorded as
  a step rather than left as a shared assumption. Both were raised on this page yesterday as things
  nothing was writing down.
- **The "level below D-010" is answered and it needs no sweep.** 31 bare hierarchical styles on
  `main`, one `Chart`, no container-level `.foregroundStyle` anywhere — so the exposure is the one
  site already fixed. Corroborated from the shipped art pixel-wise rather than by eye: green
  217–1,639 px per shot against 4,998–42,391 neutral text px, dominant green exactly
  `Theme.within`. **The same sampling confirms D-009 and D-011 render correctly in the art**, which
  is the first time this page has been able to say that about the images rather than about the
  source.
- **A bounded answer beats a chore list.** The useful output of a sweep was "30 of 31 are provably
  fine and here is the class that isn't", not thirty edits. The class reopens if a second `Chart`
  lands or anything acquires a container-level foreground style, and that belongs in D-011.
- **The colour ruling is made and swept, not patched.** [DECIDED] xian, 09-24: green, with
  consistency and no corner-cutting as the standard. Landed as **D-009** (the pair on every screen
  that names a side), **D-010** (eleven raw system colours retired; two tokens are the whole
  palette; no red) and **D-012** (the spelling). `6cccc56` on `screenshot-fixture`.
- **The check anyone can run:** `grep -rn 'foregroundStyle(\.\(orange\|green\|red\|blue\)' OptiListen`
  returns nothing, and `grep -rn practising OptiListen` returns nothing. **Stated as a command
  rather than as a claim,** because that is the difference this month keeps teaching.
- **A decision register now exists — `docs/decisions.md`.** Fourteen entries backfilled to D-001.
  It exists because D-004 proved the gap: a decision can be made, written into the code's own doc
  comment, and still reach only one of the three screens it was meant for, with nothing anywhere
  recording the intent.
- **Pard closed the battery defect before this pass started** (`e64a977`) — all six re-shot with
  `--batteryState unplugged`. Shots 3 and 5 need one more pass for the green.

- **The six 6.9-inch screenshots exist and are the right size.** [EVIDENCED] `sips` on all six PNGs
  on `origin/screenshot-fixture@0b4973f`: 1320 x 2868 each, byte sizes matching `git diff --stat`.
  Read by me rather than taken from Pard's capture log.
- **Looking at an artifact beats reading a report of it, again.** Pard checked the art against my
  storyboard and reported one deviation. Opening the images found that the deviation pointed the
  other way, plus a charging battery in all six, a spelling the app cannot keep straight, and a weak
  lead image. **None of that was visible in a capture log, and none of it was Pard's to catch.**
  The standing rule keeps earning its place: *an agent's report of its own output is not evidence
  about the output.*
- **The device-family edit is on a branch, not on `main`** — so 2.0 (5), which is on your phone and
  Dan's, is untouched by today's work. It lands when you merge and (6) is cut.
- **The privacy 404 has a cause and a one-line fix**, both Pard's: GitHub Pages plus a
  `spa-github-pages` shim, fixed by emitting a static `privacy/index.html` at build. Site repo,
  your deploy.


- **The iPad question is closed, and it closes as "drop it".** [EVIDENCED] three ways on 09-23: the
  1.x `project.pbxproj` — read with one `gh api` call, no clone — sets no `TARGETED_DEVICE_FAMILY`
  and its `Info.plist` no `UIDeviceFamily`; the live Compatibility block lists iPhone, iPod touch,
  Mac and Apple Vision but **not iPad**; the iTunes lookup returns 4 iPhone and **0 iPad**
  screenshots, a set App Store Connect would have required. The `[OPEN]` in store-content Finding 2
  was the only thing holding the recommendation back, and the answer makes the shoot smaller.
- **A clone is not the only way to read a private repo.** Pard reported truthfully that
  `listenup-mobile` is not on Amber, and the question was one file away on the machine this rollup
  is written from. Worth keeping as a rule: **before accepting "not available here", ask whether the
  question needs the whole repo or one file.**
- **A fifth metadata surface, and nobody has looked at it: Mac and Apple Vision.** Same class as the
  bundle ID, the `Info.plist` version string, the iOS minimum and the headphones sentence — metadata
  the compiler never checks and the submission does. This one is a checkbox.
- **The privacy URL is a 404 with a JavaScript parachute**, and the policy is dated 4 July 2022 —
  correcting this page's own "not touched since February 2023", which was the repo's commit date
  rather than the document's. Mine to correct, and corrected here.

- **The submission date is answered, and the item is closed as a decision rather than a gap.**
  xian, relayed by Pard 09-22: *"We didn't have a release candidate till the latest build, build 5.
  All earlier builds crashed or were unusably buggy. This build may be the one we submit."* **Dan's
  test is the gate, no sooner than this weekend.** Five uploads were the road to the first
  candidate, not five missed chances to submit. My rev-29/30 framing of it as the only unscheduled
  deadline item was the wrong shape, and the correction is his wording.
- **The App Store content pass is drafted** — `docs/store-content-2.0.md`, this pass. Listing
  metadata with computed character counts, what's-new, App Review notes, age-rating and privacy
  answers, and a six-shot screenshot storyboard with required sizes. Nothing published.
- **A fourth member of the metadata class, and this one is dirty.** The live description's first
  sentence instructs headphones; `PracticeLoopView.swift:66` refuses to record a share when
  headphones are in use. Caught by reading the listing against the source rather than by reading
  either alone.
- **The screenshot shoot has a code dependency, named before anyone tries it.** The listening
  screen takes a `LiveTalkRatioSource` and the Simulator has no microphone, so two of the six shots
  cannot be captured until a `#if DEBUG` fixture source exists. Pard's lane; kindbook has no Xcode
  and cannot take a screenshot at all.

- **Dan was provisioned all along, and has had the build since the 21st.** Pard's App Store Connect
  read: internal group `DinP`, Dan's state **INSTALLED**, four testers on the app in total. Internal
  groups receive every processed build automatically, so 2.0 (5) reached him at 15:36 UTC on 09-21.
  **My [INFERRED] absence was wrong, in exactly the direction I flagged as the likely error.** The
  needs-you item loses its work and keeps only its sentence.
- **No 2.0 version record exists — [EVIDENCED], not inferred.**
  `GET /v1/apps/1593948410/appStoreVersions`, 09-21: 1.1 `READY_FOR_SALE`, 1.0
  `REPLACED_WITH_NEW_VERSION`, nothing from the 2.0 line. Five builds have cleared processing with
  no record to attach to; App Review has never been entered.
- **The public listing agrees, from the surface Apple shows customers** — live, version **1.1**,
  updated **07/19/2023**, seller Christian Crumlish, read 2026-09-22. Two independent records rather
  than one record read twice, and it re-confirms the 09-19 correction that the shipped 1.x is 1.1.
- **A metadata class swept, and clean this time.** The listing reads *"Requires iOS 11.0 or later"*
  while 2.0 requires iOS 17, so submission raises the published minimum six major versions. The
  09-07 analytics close it — every download since 2024 is on 17+. Third member of the class that
  produced the bundle-ID error and the Info.plist version error; this one came back clean, and it is
  worth recording that it was looked at.

- **2.0 (5) is built, uploaded, processed and testable.** Pard's delivery
  `3d55569b-1fea-4d44-821d-70e06a607afd`, from `main` at `de7f997`, and Apple's confirmation 82
  seconds after his memo landed: the processing mail and the TestFlight *"now available to test"*
  mail, both 2026-09-21 15:36 UTC. **Confirmed from Apple's mail rather than from any exit code**,
  per the 09-11 rule. No ITMS warnings — the three plist gates that bit 2.0 on 09-11 stayed fixed.
- **Rev 28's single needs-you item is closed**, about eleven hours after it was written.

- **Pard's hold is acknowledged and clean.** Both of last night's memos read in order, second
  superseding the first, **nothing built from the morning tree and nothing discarded** — Amber was
  rebooting through the window. Build conditions restated by him: current `main`, build number 5,
  design pass included, spec read first. Waiting on xian's scheduling, not on any work.
- **Apple mail re-read this pass and it is empty in the way that means nothing new** — newest
  OptiListen mail is still the 2.0 (4) processing notice, 2026-09-17 00:12 UTC. No review state, no
  removal or Improvement mail. The limit stands: that channel speaks to the clock and to nothing
  else.

- **Pard's App Store Connect readback is closed** (09-18 evening). Versions on the record: 1.1
  `READY_FOR_SALE`, 1.0 `REPLACED_WITH_NEW_VERSION`; **no 2.0 version exists in review**. The API has
  no removal-date field, so the 08-26 notice is the only source for 24 November.
- **Fallback build provenance confirmed**: xian's 09-17 re-rank, item 6, quoted verbatim by Pard.
  Prep and hold is Pard's; shipping is xian's call. Pard fixed `mediajunkie/docs/backlog.md` at
  source, which had carried neither.
- **Correction: the shipped 1.x is 1.1, not 1.3 (6).** Verified against the public App Store
  listing (1.1, 2023-07-19) and Pard's ASC table. 1.3.6 is the source repo's head, bumped
  2023-05-30. No effect on 2.0.
- **2.0 (4) shipped, processed, and is testable** — delivery `d3c30721`, Apple's processing mail
  2026-09-17 00:12:45 UTC, TestFlight *available to test*. **Pard's binary check discriminates this
  time and he proved it against a control** before believing it: `buffersReceived` 0→2, `sample
  input format` 0→1, `tap installed` 0→1 against the preserved 2.0 (3) IPA. Artifact clean:
  `CFBundleVersion = 4`, mic string, launch screen, correct signing.
- **`62feb22` did not compile, and Pard repaired it rather than round-trip** — `9d2fd19`. My
  `@Sendable` on `sampleLevel`'s tap made the compiler strict about the capture: `AVAudioPCMBuffer`
  is not `Sendable`, so building the `Double` inside the `Task` became "passing closure as a
  'sending' parameter." He applied the shape `start()`'s tap twenty lines up already uses — compute
  the level first, send that across — marked it at the site with his name, the date and "compile fix
  only," and led his memo with it. **Authority confirmed this pass: he keeps it.** The line: if the
  fix is the file's own existing pattern applied to the same problem, take it; if there are two
  reasonable shapes, or behaviour changes, stop at the error message. **My change was incomplete,
  not misapplied** — `swiftc -parse` on kindbook has no SDK and does no isolation analysis, which is
  the second cycle this month lost to the gap between syntax-checked and compiled.
- **The removal clock was re-derived from Apple rather than from us** — see rev 22 above. Correcting
  my own line, in the rollup that carried it.
- **The Apple mail channel is now a real instrument.** The pobox→Gmail forward carries App Store
  Connect mail, not just receipts: the full processing chain for 2.0 (1)–(4) and One Job's entire
  1.1 review are readable. **What is still absent is any removal or App Store Improvement mail at
  all** — the 08-26 notice predates the forward, so its absence is expected and proves nothing.

- **The diagnostic build is written and pushed** — `62feb22`, 2.0 (4). `CaptureState.failed(String)`
  set before every throw so the reason survives a caller that swallows; `buffersReceived` separates
  an engine receiving nothing from one that never started; `isCalibrated` says when a number is
  computed against placeholder thresholds; a rolling event log copyable from the listening screen,
  a stethoscope toolbar button, and a failed-calibration screen. `stop()` is now reachable from
  every state (it guarded on `isRunning`, set last in `start()`, so a failed start could never be
  torn down) and the interruption-observer token is held and removed.
  **Syntax-checked only** — `swiftc -parse` clean on kindbook, which has no SDK, so no type
  checking and no isolation analysis. Not compiled.
- **The ask about the 2.0 (3) crash submission is answered: there isn't one.** Pard ran it twice
  and re-pulled the logbody to rule out a cached list. Newest is 09-15 against 2.0 (2).
- **One positive result survives from xian's report:** 2.0 (3) did *not* crash immediately the way
  (2) did. That is the only evidence anyone has that the `@Sendable` fix did anything, and no
  fourth theory has been built on it.

- **The five-whys is done and the root cause is named** — `docs/architecture-review-2026-09-16.md`.
  Every defect this month (missing usage string → 0 Hz tap → isolation trap → tracks nothing)
  presents identically: the app dies or does nothing and tells no one why. One property, four
  symptoms.
- **Five more defects found by reading rather than by crashing:** `.unavailable` passes `isUsable`
  (30 dB gap against an 8 dB threshold); `stop()` is unreachable after a failed `start()` because
  `isRunning = true` is the last line and `stop()` guards on it; `observeInterruptions()` adds an
  observer on every `start()` and discards the token so it can never be removed; time accounting is
  buffer-count × 0.1s rather than elapsed seconds, which makes `evidenceCoverage` a fiction that
  looks like a measurement; one `AVAudioEngine` has two owners and no arbitration. **None of these
  is being proposed as the crash.**
- **2.0 (3) built, archived and uploaded** — delivery `30256500`, `ARCHIVE SUCCEEDED`, zero new
  warnings, artifact-checked. The `@Sendable` fix compiles clean, which was the open question I
  couldn't answer from kindbook.
- **Pard retracted his own binary check as vacuous before reporting it as verification** — he ran it
  against the 2.0 (2) binary, which demonstrably crashes on that assert, and got the same `0`. The
  rule survives; his implementation didn't discriminate. Keeping the previous IPA on disk is what
  made the control possible, and is now standing practice.

## In flight

| Owner | Item | Waiting on |
|---|---|---|
| **Cairn** | `calibration: Calibration?` and delete `.unavailable`; make "I don't know" representable | **deliberately held out of 2.0 (4)** — it changes classification, and an observing build should not change what it observes. `isCalibrated` makes it visible meanwhile |
| **Themis** | Carry the first-person convention to Janus as a Tier-2 candidate, in **his** framing of the recurrence, not mine | his call, taken 09-16 |
| **Cairn** | Lifecycle state machine, one engine owner, `stop()` reachable from every non-idle state; real buffer-duration accounting | after the diagnostic build reports |
| **Pard** | Prep the flag-off-capture fallback build and hold it (xian's 09-17 re-rank, item 6) | after 2.0 (5) reports; shipping it is xian's call |
| **Cairn** | Update Dan's brochure once a build survives use, and fix the AI writing tics he flagged | xian forwarding the feedback; a working build |
| **Janus** | Registry: two entries — `mediajunkie/optilisten` (app) and `Design-in-Product/optilisten` (live site) | memo 09-07; unconfirmed |

## Standing risks

- **Two builds shipped against two theories before anything was diagnosed; build 3 is the first that ships against a stack.** Both earlier theories were real defects; neither was the one. **The risk is not retired until a phone runs build 3** — a trace names a cause, and a cause is not yet a cure. The pattern to break is reasoning from source to a mechanism we can *see*, when the reporter has already named a mechanism we'd have to go look for. Pard's own rule, adopted here: **when a report names two things and you can only explain one, the one you can't explain is the finding.**
- **No instrumentation — half-retired as of 2.0 (4).** The app can now say what happened to it, on screen and in a copyable log. What is still missing is the outer half: there is no alert when a submission lands, and **a crash that produces no submission is invisible to Pard's standing check** — which is exactly what 2.0 (3) did. xian raised this on 09-14.
- **Compiling is not running, and running is not being used.** 2.0 has been launched on a real phone twice and died both times. Nobody has yet watched calibration, the mic tap, or the loop behave in an actual conversation.
- **Calibration is `Codable` and nothing persists it** — recalibrates every cold launch.
- **The fleet has one signing path and it expires Aug 2027.** The API can renew it; nothing watches for expiry.
- **The 24 Nov date exists only in the 08-26 notice.** App Store Connect's API has no removal-date field (Pard, 09-18), so it cannot be read back that way. Accepted builds do not move it: Apple stops the removal on *"an update and it's approved,"* which means App Review. Re-read from the API on 09-21: **no 2.0 version record exists at all**, so review has never been entered.
- **Apple has rejected this app once before** (July 2023, background modes). 2.0 omits `UIBackgroundModes` — which is also, possibly, the thing making it crash. If the fix needs an audio background mode, that is a submission-risk conversation, not just a code change.
- **Age-rating social-media questions** at submission; ~10 min; answers are "no."
- **A claim in this rollup is not a commit.** Rev 17 marked the isolation fix as mine and owned; the fix then sat unwritten for 58 hours while the row read — to Pard, to Janus, and to the next instance of me — exactly like work in progress. Ownership recorded here now has to be followed in the same fire by either the work or a stated hand-off.
