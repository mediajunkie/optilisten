# OptiListen — what needs xian

**Maintained by:** Cairn · **Updated:** 2026-09-10 (rev 13) · **Deadline:** 2026-11-24 (75 days — forward now in place; re-verify on Apple's next mail)

Canonical state. Janus may summarize this into the cross-project meta-rollup.
Rendered for xian as an artifact — https://claude.ai/code/artifact/54087bd3-f172-494f-b79b-49d3406f5215
(republish that same URL rather than creating a new one). This file is the source; the artifact follows it.
The artifact's HTML source lives beside this file at `docs/attention.html`, so a run edits it rather than retyping it.

> **rev 11: the account question is answered, and the ask is now unambiguous.** Pard read Xcode's
> preference file directly from disk rather than through his session cache, and reconstructed the
> timeline: One Job's provisioning profiles were minted 13–15 August by the only Xcode install
> that has ever been on Amber, and the account list on disk is empty today. **An Apple ID was
> signed in in mid-August, minted those profiles, and is no longer there.** xian's memory and
> Pard's measurement were both correct and describe different weeks. The ask is not "sign in to
> something you say is already signed in" — it is **re-add an account that silently went missing**.
> Everything else is green: the tree compiles, the bundle ID is correct, and version/build
> numbering clears an upload.

---

## Needs you

| # | Item | Why it's yours | Cost | Blocking |
|---|---|---|---|---|
| 1 | **The archive has to run where the account is visible — nothing needs adding.** You're right: `xian@pobox.com` is signed into Xcode on Amber. Since Xcode 9.3, account credentials live in the *local items* keychain, which an SSH/Background session — Pard's — cannot read, so his `No Accounts` was true for his session and false for yours. Two paths: **(a) immediate** — at the desk, open `~/Development/optilisten/OptiListen.xcodeproj`, Product → Archive → Distribute → TestFlight, ~5 min, the account is visible there; **(b) durable, so Pard can archive unattended** — Apple DevRel's workaround (remove account, quit Xcode, `defaults write com.apple.dt.Xcode DVTDeveloperAccountUseKeychainService_2 -bool NO`, reopen, re-add). Coral archived One Job from this machine on 09-05 and has been asked which path was used. **Don't do (b) until Coral answers — it may already be done.** | (a) ~5 min at the desk, or wait for Coral | archive → TestFlight → Dan's prototype |

## Resolved this pass

- **"The account is absent" — retracted.** It is present in xian's GUI session. Pard's SSH session cannot see the local-items keychain where Xcode has stored account credentials since 9.3 (Apple DevRel, forums thread 112606); his plist check read a key Xcode doesn't use for this. My session hypothesis was right and I accepted a disk read that "ruled it out" without checking whether the read was valid. Rollup rev 11–12 told xian to re-add an account that was there; that's the trust-erosion I flagged and then caused.

- **Apple mail now reaches a readable mailbox.** xian set up the pobox→Gmail forward on 09-10. From the next run, App Store Connect mail — deadline changes, review results — is visible to a scheduled fire. The 11-24 date can now be re-verified when Apple next writes.

- **"Which macOS session?" is answered — it was a real absence, not a session artifact.** Pard's session limitation was real and worth ruling out (he runs over SSH under `launchctl managername → Background`, not Aqua), and he ruled it out properly rather than re-asserting: `plutil -extract DVTDeveloperAccountManagerAppleIDLists xml1 -o - ~/Library/Preferences/com.apple.dt.Xcode.plist` returns an empty array **on disk**, and there is no `idmsa.apple.com` item in the login keychain. The account is genuinely gone. The mint dates (Aug 13 18:24, Aug 15 21:38) against a single Xcode install (installed Aug 5, never upgraded) are what prove it was ever there. Two true statements, six weeks apart.
- **Version and build numbering clears an upload — verified, no change needed.** The bundle-ID miss was a metadata error that fails at submission rather than at compile, so I checked its nearest sibling. 1.x source of record (`AustinWood/listenup-mobile`, `ios/ListenUp.xcodeproj/project.pbxproj`) carries `MARKETING_VERSION = 1.3`, `CURRENT_PROJECT_VERSION = 6`. 2.0 carries `MARKETING_VERSION = 2.0`, `CURRENT_PROJECT_VERSION = 1`. `2.0 > 1.3`, and build numbers are unique per version train rather than per app, so build 1 under a fresh 2.0 collides with nothing. **Verified against the source of record; not against the live App Store listing**, which reads through App Store Connect behind `xian@pobox.com` (item 2). The conclusion holds either way — any unlogged 1.4 would still sort below 2.0.
- **Two stale comments in `project.yml` retired** (`ba1023c`). The `DEVELOPMENT_TEAM` line still read *"confirmed owner of `com.optilisten.ios`"* — the superseded identifier, preserved in the comment beside the corrected setting, which is exactly where someone re-derives the wrong value later. And `deploymentTarget` still carried an open TODO, *"Confirm against App Analytics installed-base before locking this in,"* answered on 09-07. **Comments only — no setting changed, so no regenerate is required and Pard's green build stands.**
- **The bundle ID was wrong and is fixed** (`73f2b95`). The shipped identifier is **`com.longskymedia.optilisten`** (from the 1.x `project.pbxproj`), not `com.optilisten.ios` from Austin's 2022 setup email. Pard has since regenerated and rebuilt green on the corrected value, and confirmed it is baked into the generated project rather than trusting the spec: `grep PRODUCT_BUNDLE_IDENTIFIER OptiListen.xcodeproj/project.pbxproj` → `com.longskymedia.optilisten`.
- **Bundle-ID ownership is not an issue.** The reverse-domain string is a naming convention with no bearing on which Apple team owns the identifier; `com.longskymedia.optilisten` is registered to `YZ4B34YGX9`. Dan's Apple ID is not involved.
- **The tree compiles, end to end.** `b6a6a5b` cleared the isolation error; `b22f06b` cleared the access-control error behind it. This was the project's top standing risk for four days and it is now measured rather than estimated.
- **The mail channel was never broken** — timing, plus a real gap Pard closed by adding `mediajunkie/optilisten` to his standing duty-cycle sweep.
- **The 403 on scheduled cloud sessions is not Pard's to fix.** Amber has no `GH_TOKEN` and authenticates over SSH, so nothing host-side is upstream of the container. Back with xian as an account-side question; it has not bitten since these fires started reaching kindbook.

## In flight

| Owner | Item | Waiting on | Since |
|---|---|---|---|
| **Pard** | **Archive and hand over a TestFlight build** — the last step, and the only one left. He has said he will do it the same hour the account lands, which makes the Dan prototype assemblable that hour too | item 1 above, and nothing else | 2026-09-09 |
| **Pard** | **Add an empty-account-list check to Amber's drift-checked guards**, so a silently vanished Apple ID surfaces in a duty cycle rather than at a submission deadline. His lane; he is doing it after the archive | item 1 | 2026-09-10 |
| **Janus** | Registry: two entries, not one — `mediajunkie/optilisten` (the app, Cairn) and `Design-in-Product/optilisten` (the live site, no owner). Pard's 09-07 log says the app path was repointed; whether the site kept its own entry is unconfirmed | memo sent 2026-09-07 | 2026-09-07 |
| **Cairn** | Deferred-reflection resume flow in `HomeView`, currently a placeholder — the mechanic that makes "Later" mean something other than "abandoned"; mine `RecordSession.tsx` + the voice patch for how 1.x did speaker discrimination. Calibration persistence folds into this | not blocked | 2026-09-06 |
| **Cairn** | **The Dan package** — options (minimally comply / reposition / sunset), a prototype he can hold, and a recommendation. Prototype means a TestFlight build, so it sits downstream of item 1; the recommendation has its baseline in `docs/analytics-2026-09-07.md` | item 1 | 2026-09-06 |
| **open** | Whether Cairn runs as Cowork or Code, and on which machine | xian; not urgent, and less pressing now that the scheduled Cowork run has proven it can reach a Mac and push unattended four times | 2026-09-06 |

## Closed since 2026-09-05

| Item | Resolution |
|---|---|
| **Which macOS session archived One Job?** | Neither — the account is genuinely absent now and was present mid-August. Measured from disk, not from the session cache. Item 1 is now "re-add," not "investigate." |
| **Version/build collision at upload** | Checked and clear. 1.x last carried 1.3 (build 6); 2.0 build 1 clears both. No change before archiving. |
| **The 2.0 tree has never been compiled** | Compiled 2026-09-09 on Amber, simulator target with `CODE_SIGNING_ALLOWED=NO`. |
| **Error 1 — `LiveMicSource.swift:37`** | `@MainActor LiveMicSource` conforming to `LiveTalkRatioSource`, whose `currentShare` and `observedDuration` were nonisolated. Fixed at `b6a6a5b` by isolating the two protocol requirements. **Verified by rebuild.** |
| **Error 2 — `CalibrationView.swift:127`** | `source.calibration = calibration` against a `private(set)` setter. Fixed at `b22f06b` by adding `applyCalibration(userLevel:ambientLevel:)` to `LiveMicSource` rather than opening the setter. **Verified 2026-09-10**, with `b22f06b` confirmed as an ancestor of the built HEAD before reporting. |
| **The 2.0 tree compiles clean, end to end** | `** BUILD SUCCEEDED **` on Amber 2026-09-10 — 1,151 lines, Swift 6 `SWIFT_STRICT_CONCURRENCY: complete`, zero errors, zero warnings, iOS 26.5 SDK. Rebuilt green again the same day on the corrected bundle ID. |
| **The wrong bundle ID** | `com.longskymedia.optilisten`, from the 1.x `project.pbxproj`. Fixed `73f2b95`, comment cleaned `ba1023c`, verified in the generated project by Pard. |
| **Does automatic signing provision on its own?** | **No** — it fails one step before the portal, because there is no Apple account on Amber. Now item 1. |
| **`DEVELOPMENT_TEAM` in the repo** | It wasn't — Pard had set it locally only. Committed at `b6a6a5b`; both copies now agree. |
| **Scheduled mail check unbound to a device** | Fixed and proven unattended across four fires — 09-09 16:00 and 23:06 UTC, 09-10 16:00 and 23:1x UTC — each reaching kindbook's shell, rebasing both repos and pushing. |
| **Residual 26.5-SDK worry** | Retired. One Job reached "Pending Developer Release" 2026-09-08 through Amber's Xcode 26.6 / iOS 26.5 toolchain. |
| **Where is the 1.x source?** | `AustinWood/listenup-mobile` — private, on the contractor's personal account. Your `mediajunkie` login already had read access. |
| **Upgrade or rewrite?** | Rewrite. RN 0.66.0 with `patches/react-native+0.66.0.patch` — the framework itself was patched. |
| **Xcode blocker on Amber** | Never existed. Cairn measured kindbook and reported it as Amber; corrected 2026-09-06. |
| **Whose Apple team owns the App Store record?** | xian's — `Seller: Christian Crumlish`, team `YZ4B34YGX9`, created Aug 2022. |
| **Which repo does 2.0 live in?** | `mediajunkie/optilisten`. Old site preserved at `a639400`. |
| **App Store analytics** | 96 lifetime downloads, ~1.3 sessions each, retention nil — but 548 impressions and 5 first-time downloads in the last 30 days with zero marketing. iOS 17 target confirmed. |
| **Dan's role** | Co-decider, not courtesy consult. |

## Standing risks

- **Compiling is not running.** The tree builds clean; no one has yet watched it *behave* — the mic tap, the calibration flow, the practice loop under a real conversation. TestFlight is where that gets answered, which is one more reason item 1 is the whole critical path.
- **Calibration is `Codable` and nothing persists it.** The user recalibrates from scratch on every cold launch. Folded into the `HomeView` work.
- **The fleet has exactly one signing path, and it expires 2027-08** — and it has now demonstrated it can degrade silently. One Job's two cached profiles are the only thing letting anything on Amber archive, and the account that minted them vanished without a trace for roughly four weeks. Pard is adding an empty-account-list check to Amber's drift guards, which closes this; until then it stands.
- **The 2026-11-24 date has not been re-verified since the original notice.** Item 2.
- **The app was rejected by Apple once before**, July 2023, over background modes. 2.0 omits `UIBackgroundModes` deliberately, but expect scrutiny there.
- **Age-rating social-media questions** must be answered at submission (~10 min in App Store Connect). A gate, not a deadline. Answers are "no" across the board.

## Method notes

- **When one metadata error surfaces, sweep for its siblings rather than waiting for the next one.** The wrong bundle ID would have failed at submission with no slack. That is a class — metadata that the compiler never checks and the upload does — so after it was fixed I went looking for the rest of the class rather than moving on. Version/build monotonicity was the obvious next member; it came back clean, which is a result and not a wasted pass. Both were reads of the 1.x artifact, which is the same source that settled the first one.
- **Two people can both be right about a machine if the machine changed between them.** xian said his account was on Xcode on Amber; Pard measured `No Accounts` every cycle. The reflex is to decide who is mistaken. The answer was a timestamp comparison — profiles minted 13–15 August against an install dated 5 August and an empty account list today — and it cost one command. An argument about who was right would have obscured the actual finding, which is that a signing account can disappear unwitnessed.
- **The instruction is not the artifact.** `com.optilisten.ios` came from an email telling xian what to create. The 1.x project file — the thing that actually shipped — said otherwise the whole time. When both exist, read the artifact. And when you fix the setting, fix the comment beside it: a superseded value in prose is how the error gets re-derived six weeks later.
- **The first error hid the second.** On a tree that has never compiled, each fix buys one more file's worth of visibility, so the honest forecast is "more errors, serially," not "nearly there."
- **A compile error is not always a concurrency error.** Reading `private(set)` as an invariant rather than an obstacle is what picked the fix, and the fix was a design decision the compiler had no opinion about.
- **A commit isn't mail.** The 08:11 fire pushed `b22f06b` and sent no memo, so Pard didn't know. Every fix now ships with its memo in the same fire.
- **Two Cairn instances worked this repo inside fifteen minutes and the rollup nearly lost an update.** Read `git log origin/main -- docs/attention.md` and the artifact immediately before writing, because the other writer may be another instance of me, minutes old. Followed this pass; no collision.
- **Pard corrected himself twice in two days, both the same shape** — reporting the state of his machine as the state of the world. `git show HEAD:<file>` before trusting any "I set X" is a standing check, and it applies to me as much as to him. Worth noting he did not make it a third time: given a chance to re-assert "No Accounts," he checked the disk instead.
