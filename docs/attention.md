# OptiListen — what needs xian

**Maintained by:** Cairn · **Updated:** 2026-09-10 (rev 8) · **Deadline:** 2026-11-24 (75 days, unverified — see item 2)

Canonical state. Janus may summarize this into the cross-project meta-rollup.
Rendered for xian as an artifact — https://claude.ai/code/artifact/54087bd3-f172-494f-b79b-49d3406f5215
(republish that same URL rather than creating a new one). This file is the source; the artifact follows it.
The artifact's HTML source now lives beside this file at `docs/attention.html`, so a run edits it rather than retyping it.

> **rev 8: the fix held, and the next error is already fixed too.** Pard rebuilt against `b6a6a5b` —
> `LiveMicSource.swift:37` is gone, and rev 7's top standing risk ("the fix is unverified") is closed
> by a real compiler. One error was behind it, `CalibrationView.swift:127`, plain access control
> rather than concurrency; fixed and pushed at `b22f06b`, awaiting the next rebuild. **Nothing has
> changed about what needs you: one Apple ID sign-in on Amber, still the only thing on the critical
> path.**

---

## Needs you

| # | Item | Why it's yours | Cost | Blocking |
|---|---|---|---|---|
| 1 | **Sign into Xcode on Amber** — Xcode → Settings → Accounts → add the Apple ID that owns team `YZ4B34YGX9` | Unchanged from rev 7, and re-measured: Pard's duty-cycle checks read `IDE.Identifiers.Prod = ()` at every cycle overnight, most recently ~07:0x on 09-10. Amber holds the **signing certificates** (`Apple Distribution: Christian Crumlish (YZ4B34YGX9)`) but **no Apple account**, so `xcodebuild -allowProvisioningUpdates` fails with `No Accounts`. Certificates let you sign with a profile you already have; an account is what *mints* one. `com.optilisten.ios` has no profile and cannot get one until an account exists. Nobody but you can type that password. | ~2 min | archive → TestFlight → the prototype Dan holds → the submission that cancels the 24 Nov removal |
| 2 | **Forward Apple's mail to a mailbox an agent can read** | Unchanged from rev 6. Apple writes to `xian@pobox.com`. The Gmail I can read holds Apple-domain mail from 2022 and a 2024 calendar invite, but **no App Store Connect mail in 2026** except the One Job notice you forwarded by hand on 09-09. Until a pobox→Gmail rule exists for `@email.apple.com`, **no run can ever learn** if Apple moves the date, extends it, or answers a submission. | ~3 min | verification of the only hard deadline |

## Resolved this pass

- **`b6a6a5b` compiles.** Pard pulled it, ran `xcodegen generate` clean, and rebuilt the simulator target: `LiveMicSource.swift:37` is gone. Isolating the two protocol requirements rather than the conformance was the right call, and no Swift 6.2 feature was needed. Rev 7's headline standing risk is retired by measurement, not by argument.
- **`DEVELOPMENT_TEAM` is settled for real.** Pard confirmed he discarded his Amber-local edit and is building against the value on origin. Both copies now agree, and the authoritative one is in the repo.
- **The second compile error, same day it was reported.** `CalibrationView.swift:127` — `source.calibration = calibration` against a `private(set)` setter. Not a knock-on from the first fix; it was simply behind it, since the compiler stopped at `LiveMicSource` and never reached the view. Fixed at `b22f06b`.

## In flight

| Owner | Item | Waiting on | Since |
|---|---|---|---|
| **Pard** | **Rebuild the simulator target against `b22f06b`** — the `CalibrationView` access fix. Expect another error behind it rather than a clean build; that is the normal shape of a first compile, not a bad sign | the fix, pushed 08:11 PT; memo `memo-cairn-to-pard-b22f06b-pushed-rebuild-please-2026-09-10.md` sent 08:2x | 2026-09-10 |
| **Pard** | Archive attempt, once an account exists on Amber | item 1 above | 2026-09-09 |
| **Janus** | Registry: two entries, not one — `mediajunkie/optilisten` (the app, Cairn) and `Design-in-Product/optilisten` (the live site, no owner). Pard's 09-07 log says the app path was repointed; whether the site kept its own entry is unconfirmed | memo sent 2026-09-07 | 2026-09-07 |
| **Cairn** | Deferred-reflection resume flow in `HomeView`, currently a placeholder — the mechanic that makes "Later" mean something other than "abandoned"; mine `RecordSession.tsx` + the voice patch for how 1.x did speaker discrimination. Calibration persistence (below) folds into this | not blocked | 2026-09-06 |
| **Cairn** | **The Dan package** — options (minimally comply / reposition / sunset), a prototype he can hold, and a recommendation. Prototype means a TestFlight build, so it sits downstream of item 1; the recommendation has its baseline in `docs/analytics-2026-09-07.md` | item 1 | 2026-09-06 |
| **open** | Whether Cairn runs as Cowork or Code, and on which machine | xian; not urgent, and less pressing now that the scheduled Cowork run has proven it can reach a Mac and push unattended twice | 2026-09-06 |

## Closed since 2026-09-05

| Item | Resolution |
|---|---|
| **The 2.0 tree has never been compiled** | Compiled 2026-09-09 on Amber, simulator target with `CODE_SIGNING_ALLOWED=NO`. `PracticeLoopView`, `HomeView`, `OptiListenApp`, `TalkRatioSource`, `RetrospectiveSources` and `Practice` all built clean. |
| **Error 1 — `LiveMicSource.swift:37`** | `@MainActor LiveMicSource` conforming to `LiveTalkRatioSource`, whose `currentShare` and `observedDuration` were nonisolated. Fixed at `b6a6a5b` by isolating the two protocol requirements. **Verified by rebuild 2026-09-09** — the error is gone. |
| **Error 2 — `CalibrationView.swift:127`** | `source.calibration = calibration` against a `private(set)` setter. Fixed at `b22f06b` by adding `applyCalibration(userLevel:ambientLevel:)` to `LiveMicSource` rather than opening the setter: `Calibration` carries the app's thresholds (including the 0.45 ambient bias that stops the app flattering the user), so construction stays inside the type that owns them. One write site in the tree, grep-confirmed; two reads in `PracticeLoopView` untouched. **Syntax-parsed only on kindbook — awaiting Pard's rebuild.** |
| **Does automatic signing provision on its own?** | **No, and not for the reason expected.** It fails one step before the portal: there is no Apple account on Amber at all. Now item 1. |
| **`DEVELOPMENT_TEAM` in the repo** | It wasn't — Pard had set it locally only. Committed at `b6a6a5b`; local copy discarded 09-09, both now agree. |
| **Scheduled mail check unbound to a device** | Fixed and proven unattended twice — the 09-09 23:00 UTC and 09-10 15:09 UTC fires both reached kindbook's shell and pushed to both origins with no one at the keyboard. |
| **Residual 26.5-SDK worry** | Retired. One Job reached "Pending Developer Release" 2026-09-08 through Amber's Xcode 26.6 / iOS 26.5 toolchain. |
| **Where is the 1.x source?** | `AustinWood/listenup-mobile` — private, on the contractor's personal account. Your `mediajunkie` login already had read access. |
| **Upgrade or rewrite?** | Rewrite. RN 0.66.0 with `patches/react-native+0.66.0.patch` — the framework itself was patched, and those patches can't apply to anything newer. |
| **Xcode blocker on Amber** | Never existed. Cairn measured kindbook and reported it as Amber; corrected 2026-09-06. |
| **Whose Apple team owns the App Store record?** | xian's — `Seller: Christian Crumlish`, team `YZ4B34YGX9`, created Aug 2022. No transfer, no lead time. |
| **Which repo does 2.0 live in?** | `mediajunkie/optilisten`. Old site preserved at `a639400`. |
| **App Store analytics** | 96 lifetime downloads, ~1.3 sessions each, retention nil — but 548 impressions and 5 first-time downloads in the last 30 days with zero marketing. iOS 17 target confirmed. Full read in `docs/analytics-2026-09-07.md`. |
| **Dan's role** | Co-decider, not courtesy consult. He should see the 2.0 direction before it hardens. |

## Standing risks

- **`b22f06b` is unverified, in the same narrow sense as `b6a6a5b` was.** I ran `xcrun swiftc -parse` on both changed files and it passed, but kindbook has no iOS SDK — that is syntax only, with no type checking and no isolation analysis. Last time the same class of reasoning-plus-parse held up under a real compiler; that is one data point, not a method.
- **Expect more errors, and don't read them as trouble.** The compiler surfaces one at a time on a fresh tree, so "another error" is progress through the file list rather than a widening problem. Pard is feeding them raw and I'd rather he keep doing that than round them into a status.
- **Calibration is `Codable` and nothing persists it.** Not a compile error — the user simply recalibrates from scratch on every cold launch. Someone made it storable and no one stored it. Folded into the `HomeView` work rather than fixed inside a build patch.
- **The fleet has exactly one signing path, and it expires 2027-08.** One Job's two cached profiles are the only thing letting anything on Amber archive, and nothing would surface their lapse until it happened. Not urgent; should not be invisible.
- **The 2026-11-24 date has not been re-verified since the original notice.** Apple's mail reaches no mailbox an agent reads. Item 2.
- **The app was rejected by Apple once before**, July 2023, over background modes. 2.0 omits `UIBackgroundModes` deliberately, but expect scrutiny there.
- **Age-rating social-media questions** must be answered at submission (~10 min in App Store Connect). A gate, not a deadline. Answers are "no" across the board.

## Method notes

- **The first error hid the second, and that is worth expecting rather than rediscovering.** Pard's rebuild cleared `LiveMicSource:37` and immediately surfaced `CalibrationView:127`, which would have failed identically before the first fix — the compiler had simply stopped short of the view. On a tree that has never compiled, each fix buys one more file's worth of visibility, so the honest forecast is "more errors, serially," not "nearly there."
- **A compile error is not always a concurrency error.** Both suspects I have reasoned about so far were actor-isolation stories; the second error was plain access control, with no notes and no diagnostics attached. Reading `private(set)` as an invariant rather than an obstacle is what picked the fix, and the fix was a design decision the compiler had no opinion about.
- **Two Cairn instances worked this repo inside fifteen minutes, and the rollup nearly lost an update.** The 16:00 UTC scheduled fire pushed `b22f06b` at 08:11 PT and sent no memo; an interactive session opened at ~08:2x, read the commit, sent Pard the memo, logged both days and bumped the rollup to rev 8. The scheduled run then rewrote `docs/attention.md` from its own draft at 08:23. Nothing was lost — the scheduled draft happened to be a superset — but that was luck, not a merge. The rule in my notes ("read the artifact before rewriting the file, reconcile rather than overwrite") needs a sibling: **read `git log origin/main -- docs/attention.md` immediately before writing it**, because the other writer may be another instance of me, minutes old. The duplicate memo was caught and not sent.
- **Pard corrected himself twice in two days and both corrections were the same shape** — reporting the state of his machine as the state of the world (`~/Library/MobileDevice/Provisioning Profiles/` for the profiles, an uncommitted `project.yml` for the team ID). `git show HEAD:<file>` before trusting any "I set X" is now a standing check, and it applies to me as much as to him.
