# OptiListen — what needs xian

**Maintained by:** Cairn · **Updated:** 2026-09-10 (rev 9) · **Deadline:** 2026-11-24 (75 days, unverified — see item 2)

Canonical state. Janus may summarize this into the cross-project meta-rollup.
Rendered for xian as an artifact — https://claude.ai/code/artifact/54087bd3-f172-494f-b79b-49d3406f5215
(republish that same URL rather than creating a new one). This file is the source; the artifact follows it.
The artifact's HTML source now lives beside this file at `docs/attention.html`, so a run edits it rather than retyping it.

> **rev 9: BUILD SUCCEEDED.** The whole tree compiles clean on Amber — 1,151 lines of SwiftUI,
> Swift 6 with `SWIFT_STRICT_CONCURRENCY: complete`, zero errors and zero concurrency warnings,
> against the iOS 26.5 SDK on the machine that will ship it. Two errors, two fixes, two rebuilds,
> in under a day once the loop was running. Pard checked `git merge-base --is-ancestor b22f06b HEAD`
> before saying so, because "the build passed" and "the build passed *with your fix*" are different
> claims. **The compile risk is retired, and exactly one thing now stands between this project and a
> TestFlight build: your Xcode sign-in on Amber. It is not code and it is about two minutes.**

---

## Needs you

| # | Item | Why it's yours | Cost | Blocking |
|---|---|---|---|---|
| 1 | **Sign into Xcode on Amber** — Xcode → Settings → Accounts → add the Apple ID that owns team `YZ4B34YGX9` | Unchanged from rev 7, and re-measured: Pard's duty-cycle checks read `IDE.Identifiers.Prod = ()` at every cycle overnight, most recently ~07:0x on 09-10. Amber holds the **signing certificates** (`Apple Distribution: Christian Crumlish (YZ4B34YGX9)`) but **no Apple account**, so `xcodebuild -allowProvisioningUpdates` fails with `No Accounts`. Certificates let you sign with a profile you already have; an account is what *mints* one. `com.optilisten.ios` has no profile and cannot get one until an account exists. Nobody but you can type that password. | ~2 min | archive → TestFlight → the prototype Dan holds → the submission that cancels the 24 Nov removal |
| 2 | **Forward Apple's mail to a mailbox an agent can read** | Unchanged from rev 6. Apple writes to `xian@pobox.com`. The Gmail I can read holds Apple-domain mail from 2022 and a 2024 calendar invite, but **no App Store Connect mail in 2026** except the One Job notice you forwarded by hand on 09-09. Until a pobox→Gmail rule exists for `@email.apple.com`, **no run can ever learn** if Apple moves the date, extends it, or answers a submission. | ~3 min | verification of the only hard deadline |

## Resolved this pass

- **The tree compiles, end to end.** `b6a6a5b` cleared the isolation error; `b22f06b` cleared the access-control error behind it; Pard's rebuild this morning returned `** BUILD SUCCEEDED **` with nothing left. This was the project's top standing risk for four days and it is now measured rather than estimated.
- **`DEVELOPMENT_TEAM` is settled for real.** Pard discarded his Amber-local edit and is building against the value on origin. Both copies agree and the authoritative one is in the repo.
- **The mail channel was never broken — it was timing, plus a real gap Pard closed.** My 09-09 sync ran 33 minutes before his first reply of the day existed, so "no response" was accurate when written and stale within the hour. The underlying cause was that `mediajunkie/optilisten` had never been in his standing duty-cycle sweep; he was reading my mail by hand. Added to the sweep this morning, so the floor is now one duty cycle rather than whether he remembered.
- **The 403 on scheduled cloud sessions is not Pard's to fix.** Amber authenticates over SSH as `mediajunkie` with no `GH_TOKEN` at all, so there is no host-side credential upstream of the cloud container. Wren hitting the same wall on a different repo makes it a property of the Cowork scheduled-session environment. It is back with xian as an account-side question — and it has not bitten since, because these fires reach kindbook's shell instead.

## In flight

| Owner | Item | Waiting on | Since |
|---|---|---|---|
| **Pard** | **Archive and hand over a TestFlight build** — the last step, and the only one left. He has said he will do it the same hour the account lands, which makes the Dan prototype assemblable that hour too | item 1 above, and nothing else | 2026-09-09 |
| **Janus** | Registry: two entries, not one — `mediajunkie/optilisten` (the app, Cairn) and `Design-in-Product/optilisten` (the live site, no owner). Pard's 09-07 log says the app path was repointed; whether the site kept its own entry is unconfirmed | memo sent 2026-09-07 | 2026-09-07 |
| **Cairn** | Deferred-reflection resume flow in `HomeView`, currently a placeholder — the mechanic that makes "Later" mean something other than "abandoned"; mine `RecordSession.tsx` + the voice patch for how 1.x did speaker discrimination. Calibration persistence (below) folds into this | not blocked | 2026-09-06 |
| **Cairn** | **The Dan package** — options (minimally comply / reposition / sunset), a prototype he can hold, and a recommendation. Prototype means a TestFlight build, so it sits downstream of item 1; the recommendation has its baseline in `docs/analytics-2026-09-07.md` | item 1 | 2026-09-06 |
| **open** | Whether Cairn runs as Cowork or Code, and on which machine | xian; not urgent, and less pressing now that the scheduled Cowork run has proven it can reach a Mac and push unattended twice | 2026-09-06 |

## Closed since 2026-09-05

| Item | Resolution |
|---|---|
| **The 2.0 tree has never been compiled** | Compiled 2026-09-09 on Amber, simulator target with `CODE_SIGNING_ALLOWED=NO`. `PracticeLoopView`, `HomeView`, `OptiListenApp`, `TalkRatioSource`, `RetrospectiveSources` and `Practice` all built clean. |
| **Error 1 — `LiveMicSource.swift:37`** | `@MainActor LiveMicSource` conforming to `LiveTalkRatioSource`, whose `currentShare` and `observedDuration` were nonisolated. Fixed at `b6a6a5b` by isolating the two protocol requirements. **Verified by rebuild 2026-09-09** — the error is gone. |
| **Error 2 — `CalibrationView.swift:127`** | `source.calibration = calibration` against a `private(set)` setter. Fixed at `b22f06b` by adding `applyCalibration(userLevel:ambientLevel:)` to `LiveMicSource` rather than opening the setter: `Calibration` carries the app's thresholds (including the 0.45 ambient bias that stops the app flattering the user), so construction stays inside the type that owns them. One write site in the tree, grep-confirmed; two reads in `PracticeLoopView` untouched. **Verified 2026-09-10:** the tree builds clean, and Pard confirmed `b22f06b` was an ancestor of the built HEAD before reporting it. |
| **The 2.0 tree compiles clean, end to end** | `** BUILD SUCCEEDED **` on Amber 2026-09-10 — 1,151 lines, Swift 6 `SWIFT_STRICT_CONCURRENCY: complete`, zero errors, zero concurrency warnings, iOS 26.5 SDK. Two errors found and fixed in under a day. |
| **Does automatic signing provision on its own?** | **No, and not for the reason expected.** It fails one step before the portal: there is no Apple account on Amber at all. Now item 1. |
| **`DEVELOPMENT_TEAM` in the repo** | It wasn't — Pard had set it locally only, and owned it plainly: "I reported the state of my machine as the state of the world." Committed at `b6a6a5b`; local copy discarded 09-09, both now agree. |
| **Scheduled mail check unbound to a device** | Fixed and proven unattended across three fires — 09-09 16:00 and 23:06 UTC, 09-10 16:00 UTC — each reaching kindbook's shell, rebasing both repos and pushing; the last two each fixed a compiler error. |
| **Residual 26.5-SDK worry** | Retired. One Job reached "Pending Developer Release" 2026-09-08 through Amber's Xcode 26.6 / iOS 26.5 toolchain. |
| **Where is the 1.x source?** | `AustinWood/listenup-mobile` — private, on the contractor's personal account. Your `mediajunkie` login already had read access. |
| **Upgrade or rewrite?** | Rewrite. RN 0.66.0 with `patches/react-native+0.66.0.patch` — the framework itself was patched, and those patches can't apply to anything newer. |
| **Xcode blocker on Amber** | Never existed. Cairn measured kindbook and reported it as Amber; corrected 2026-09-06. |
| **Whose Apple team owns the App Store record?** | xian's — `Seller: Christian Crumlish`, team `YZ4B34YGX9`, created Aug 2022. No transfer, no lead time. |
| **Which repo does 2.0 live in?** | `mediajunkie/optilisten`. Old site preserved at `a639400`. |
| **App Store analytics** | 96 lifetime downloads, ~1.3 sessions each, retention nil — but 548 impressions and 5 first-time downloads in the last 30 days with zero marketing. iOS 17 target confirmed. Full read in `docs/analytics-2026-09-07.md`. |
| **Dan's role** | Co-decider, not courtesy consult. He should see the 2.0 direction before it hardens. |

## Standing risks

- **Compiling is not running.** The tree builds clean; no one has yet watched it *behave* — the mic tap, the calibration flow, the practice loop under a real conversation. A clean Swift 6 build says the concurrency is sound, not that the app works. The TestFlight build is where that gets answered, which is one more reason item 1 is the whole critical path.
- **Calibration is `Codable` and nothing persists it.** Not a compile error — the user simply recalibrates from scratch on every cold launch. Someone made it storable and no one stored it. Folded into the `HomeView` work rather than fixed inside a build patch.
- **The fleet has exactly one signing path, and it expires 2027-08.** One Job's two cached profiles are the only thing letting anything on Amber archive, and nothing would surface their lapse until it happened. Not urgent; should not be invisible.
- **The 2026-11-24 date has not been re-verified since the original notice.** Apple's mail reaches no mailbox an agent reads. Item 2.
- **The app was rejected by Apple once before**, July 2023, over background modes. 2.0 omits `UIBackgroundModes` deliberately, but expect scrutiny there.
- **Age-rating social-media questions** must be answered at submission (~10 min in App Store Connect). A gate, not a deadline. Answers are "no" across the board.

## Method notes

- **The first error hid the second, and that is worth expecting rather than rediscovering.** Pard's rebuild cleared `LiveMicSource:37` and immediately surfaced `CalibrationView:127`, which would have failed identically before the first fix — the compiler had simply stopped short of the view. On a tree that has never compiled, each fix buys one more file's worth of visibility, so the honest forecast is "more errors, serially," not "nearly there."
- **A compile error is not always a concurrency error.** Both suspects I have reasoned about so far were actor-isolation stories; the second error was plain access control, with no notes and no diagnostics attached. Reading `private(set)` as an invariant rather than an obstacle is what picked the fix, and the fix was a design decision the compiler had no opinion about.
- **A commit isn't mail.** The 08:11 fire pushed `b22f06b` and sent no memo; Pard's 03:0x log line "Cairn has pushed nothing further" was true when written, and nobody told him otherwise until 08:2x. Every fix now ships with its memo in the same fire.
- **Two Cairn instances worked this repo inside fifteen minutes, and the rollup nearly lost an update.** The 16:00 UTC scheduled fire pushed `b22f06b` at 08:11 PT and sent no memo; an interactive session opened at ~08:2x, read the commit, sent Pard the memo, logged both days and bumped the rollup to rev 8. The scheduled run then rewrote `docs/attention.md` from its own draft at 08:23. Nothing was lost — the scheduled draft happened to be a superset — but that was luck, not a merge. The rule in my notes ("read the artifact before rewriting the file, reconcile rather than overwrite") needs a sibling: **read `git log origin/main -- docs/attention.md` immediately before writing it**, because the other writer may be another instance of me, minutes old. The duplicate memo was caught and not sent.
- **Pard corrected himself twice in two days and both corrections were the same shape** — reporting the state of his machine as the state of the world (`~/Library/MobileDevice/Provisioning Profiles/` for the profiles, an uncommitted `project.yml` for the team ID). `git show HEAD:<file>` before trusting any "I set X" is now a standing check, and it applies to me as much as to him.
