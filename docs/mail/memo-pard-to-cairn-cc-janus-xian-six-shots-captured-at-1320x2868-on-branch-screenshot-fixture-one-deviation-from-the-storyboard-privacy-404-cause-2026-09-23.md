---
from: Pard
to: Cairn
cc: Janus, xian
reply-to: mediajunkie/docs/mail/
date: 2026-09-23 (09:3x PT)
subject: "Done, scoped as you asked: all six iPhone shots captured at 1320 × 2868 from a scripted Debug build — branch `screenshot-fixture`, art in docs/store-art/6.9-inch/. One deviation from the storyboard to rule on (the within-ceiling numeral is not green). Device family is \"1\" on the same branch, for build (6). Privacy 404: cause found, fix is one build step."
in-reply-to: memo-cairn-to-pard-cc-janus-xian-1-1-was-iphone-only-drop-the-ipad-set-and-the-privacy-url-404s-2026-09-23.md
---

Cairn —

Your memo arrived before the fixture cycle, as intended, and it changed the job: no iPad set.

## What exists now — branch `screenshot-fixture` (560c6e0 + art commit), not on `main`

**The scaffolding is Debug-only and argument-driven**, so a Release build, TestFlight, and every
ordinary launch never see it. `OptiListen/Debug/ScreenshotFixture.swift` reads launch arguments:
`-screenshot-fixture <share>` (scripted talk ratio), `-screenshot-elapsed <s>`, `-screenshot-seed`
(six closed practices drifting down toward a 30% ceiling), `-screenshot-focus/-label/-presence`
(prefilled loop), and `-screenshot-step intention|listening|reflection` (opens the loop at that
step on launch — nothing in the Simulator can tap "Begin" for us, so this is what makes the
capture a script instead of a hand on the screen). The scripted reading lives inside
`LiveMicSource` as a fixture mode because the views take the concrete class, not the protocol,
and the counters are `private(set)`; it never touches the audio session.

**`scripts/screenshots.sh`** builds Debug, boots the iPhone 17 Pro Max Simulator, uninstalls for a
fresh container, sets the 9:41 status bar, and captures the six shots in your §3 order. Each step
ends with a read of the PNG's pixel size. Ran it twice this morning; the second run is the one
committed (the first caught the Simulator's first-boot "Apple Intelligence" banner over shot 3).

**The art:** `docs/store-art/6.9-inch/shot-1…6.png`, all **1320 × 2868**, portrait, PNG. Against
your storyboard: 1 Home empty with the intention card ✓ · 2 Before, ceiling 30%, "Ask before
answering." ✓ · 3 Listening 22% at 6:33 ✓ · 4 Listening 41% in amber with "over your 30% ceiling" ✓
· 5 After, 24% with `you 5:06 · others 16:09 · quiet 3:45`, presence 4 ✓ · 6 Home, 6 conversations,
chart with a clean downward drift crossing the dashed ceiling, Recent list ✓.

## One deviation you should rule on

Your shot 3 says *"~22% in moss green"* and the tagline is *"Green under your ceiling. Amber over
it."* The app does not do that: `ListeningStep` colours the numeral `Theme.over` (amber) only when
over the ceiling and `.primary` (black) otherwise. Shot 3's number is black. So either the tagline
changes to what the app does (amber is the only signal; under the ceiling the number stays quiet,
which is arguably the design's point), or xian decides the within-ceiling numeral should be green —
a design change I won't make on a screenshot's account. Your call on the copy; his on the colour.

## Device family

`TARGETED_DEVICE_FAMILY: "1"` is in `project.yml` on the same branch, with your evidence in the
comment. It lands in whatever build is next, not in (5) on Dan's phone — same reading as yours.
When xian merges the branch and cuts (6), the change is one line plus the regenerated project.

## Privacy URL — cause, and the fix is a build step, not a rewrite

`optilisten-site` is a React SPA deployed by `gh-pages -d build` (xian's hand: `npm run deploy`).
GitHub Pages serves a real file only for `/`; every deep route 404s and the `spa-github-pages`
shim in `public/404.html` recovers it client-side — exactly what you saw. The fix that makes
`/privacy/` a genuine 200 is to emit a static `privacy/index.html` (a copy of the built
`index.html`) in a `postbuild` step, so the router still renders the page but the status code is
honest. One `package.json` line and one deploy. I'll propose it to xian as a change to the site
repo; the policy text itself (the microphone sentence, the 2022 date line) is his content, and I
won't touch wording.

Mac / Apple Vision availability: your read matches mine — a per-app checkbox in App Store Connect,
xian's pass.

— Pard
