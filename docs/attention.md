# OptiListen — what needs xian

**Maintained by:** Cairn · **Updated:** 2026-09-09 (rev 4) · **Deadline:** 2026-11-24 (76 days)

Canonical state. Janus may summarize this into the cross-project meta-rollup.
Rendered for xian as an artifact — https://claude.ai/code/artifact/54087bd3-f172-494f-b79b-49d3406f5215
(republish that same URL rather than creating a new one). This file is the source; the artifact follows it.

---

## Needs you

| # | Item | Why it's yours | Cost | Blocking |
|---|---|---|---|---|
| 1 | **Decide whether to nudge Pard on the first build** | The build has been unblocked since 2026-09-07 — team ID resolved, Xcode 26.6 present on Amber, nothing waiting on anyone. Two days on, Pard's logs for 09-08 and 09-09 carry no OptiListen entry and no mail has arrived. Nothing is wrong; the item simply hasn't been picked up, and it is the gate in front of every downstream thing (compiler errors → TestFlight → the Dan package → the submission that cancels the removal). Only you can set its priority against Pard's other work. | ~1 min | the first compile, and everything behind it |

## Resolved this pass

- **The scheduled mail check is device-bound.** Rev 3's only "needs you" item — the 2026-09-07 task that returned `not bound: no_signed_approval` — is done. A replacement task exists (`trig_01PvG2hYtP3DaToGCs5qxsRE`, "OptiListen — check agent mail and update the attention rollup", created 2026-09-08 01:07 UTC, `0 15,23 * * *` = 08:00 and 16:00 PT). **Verified:** this run reached kindbook's shell, fetched and rebased both repos, and can push. **Not yet verified:** that an *unattended* fire carries the same access — this firing was manual (21:32 UTC, off-cron). Tonight's 23:06 UTC fire is the real test, and it needs nothing from you either way.

## In flight

| Owner | Item | Waiting on | Since |
|---|---|---|---|
| **Pard** | Set `DEVELOPMENT_TEAM = YZ4B34YGX9`, `xcodegen generate`, first build/archive on Amber | Nothing — unblocked | 2026-09-07 (2 days, no entry in Pard's logs) |
| **Pard → Cairn** | Send **raw compiler errors**, not fixes. `LiveMicSource.swift` is the least-certain file: the `AVAudioEngine` tap crossing into `@MainActor` state, and the `nonisolated` `rmsDecibels` static, under Swift 6 strict concurrency | the first build | 2026-09-07 |
| **Pard** | Test whether automatic signing provisions on its own before anyone opens the developer portal | the first archive attempt | 2026-09-07 |
| **Pard** | Rename `~/Development/OptiListen` → `optilisten-site` on Amber — xian approved | nothing | 2026-09-07 |
| **Janus** | Registry: two entries, not one — `mediajunkie/optilisten` (the app, Cairn) and `Design-in-Product/optilisten` (the live site, no owner) | memo sent 2026-09-07 | 2026-09-07 |
| **Cairn** | Deferred-reflection resume flow in `HomeView` (currently a placeholder); mine `RecordSession.tsx` + the voice patch for how 1.x actually did speaker discrimination | not blocked | 2026-09-06 |
| **Cairn** | **The Dan package** — xian promised options (minimally comply / reposition / sunset), a prototype, and a recommendation. Prototype means a TestFlight build Dan can hold, so it sits downstream of Pard's first build; the recommendation has its baseline (`docs/analytics-2026-09-07.md`) | first build | 2026-09-06 |
| **open** | Whether Cairn runs as Cowork or Code, and on which machine | xian; not urgent | 2026-09-06 |

## Closed since 2026-09-05

| Item | Resolution |
|---|---|
| **Scheduled mail check unbound to a device** | Recreated 2026-09-08 and reaching kindbook. See "Resolved this pass" for what is and isn't verified. |
| **Where is the 1.x source?** | `AustinWood/listenup-mobile` — private, Austin's personal account. xian's `mediajunkie` login already had read access; it was never lost, just filed under another name and owner. |
| **Upgrade or rewrite?** | Rewrite. RN 0.66.0 / React 17.0.2 with `patches/react-native+0.66.0.patch` — the framework itself was patched to make the app work. Those patches can't apply to anything newer. |
| **Xcode blocker on Amber** | Never existed. Amber has Xcode 26.6 / iOS 26.5 SDK. Cairn measured kindbook and reported it as Amber; corrected 2026-09-06. |
| **Whose Apple team owns the App Store record?** | xian's — `Seller: Christian Crumlish`, `DEVELOPMENT_TEAM = YZ4B34YGX9`. He created the identifier and app record himself in Aug 2022 and has carried the membership since. No transfer, no paperwork. |
| **Which repo does 2.0 live in?** | `mediajunkie/optilisten`. Took over the dormant static-site repo; old site preserved at `a639400`. |
| **App Store analytics** | Pulled 2026-09-07, full read in `docs/analytics-2026-09-07.md`. 96 lifetime downloads, ~1.3 sessions each, retention nil — but 548 impressions and 5 first-time downloads in the last 30 days with zero marketing. Deployment target iOS 17.0 confirmed; every download since 2024 is on 17+. |
| **Dan's role** | Owner, and very likely to take xian's advice — co-decider, not courtesy consult. He should see the 2.0 direction before it hardens rather than after it ships. |

## Standing risks

- **None of the 2.0 SwiftUI has ever been compiled.** Written without a Swift toolchain for SwiftUI. This is the top risk and it is Cairn's, not Pard's. It stays the top risk for as long as the first build sits unstarted.
- **The app has been rejected by Apple once before**, in July 2023, specifically over background modes. 2.0 omits `UIBackgroundModes` deliberately, but expect scrutiny in that area.
- **Age-rating social-media questions** must be answered at submission (~10 min in App Store Connect). Not a deadline, a gate. Answers are "no" across the board.

## Checked this pass, unchanged

- **Mailbox quiet.** Nothing new in `docs/mail/` since the two Pard memos of 2026-09-07, both already answered (`memo-cairn-to-pard-team-ownership-resolved`, `memo-cairn-to-pard-repo-provenance-and-your-amber-clone`, both in `mediajunkie/mediajunkie`). No memo sent this pass.
- **No Apple mail.** Nothing from Apple or App Store Connect about OptiListen in the last 14 days. The 2026-11-24 removal date has not moved.
- **Unrelated but adjacent:** One Job cleared App Store review 2026-09-08 and sits at "Pending Developer Release" — same Apple team, so the submission path is demonstrably working. Not an OptiListen item.
