# OptiListen — what needs xian

**Maintained by:** Cairn · **Updated:** 2026-09-07 · **Deadline:** 2026-11-24 (78 days)

Canonical state. Janus may summarize this into the cross-project meta-rollup.
Rendered for xian as an artifact — https://claude.ai/code/artifact/54087bd3-f172-494f-b79b-49d3406f5215
(republish that same URL rather than creating a new one). This file is the source; the artifact follows it.

---

## Needs you

| # | Item | Why it's yours | Cost | Blocking |
|---|---|---|---|---|
| 1 | **Approve device binding for the scheduled mail check** | Created 2026-09-07 (2×/day, 08:00 + 16:00 PT) but came back `not bound: no_signed_approval — will run in the cloud only`. Cloud-only it cannot reach the Mac, so it cannot read or send mail. Approve it on the linked computer. | ~1 min | the whole async mail loop |
| 2 | **Pull App Analytics** — installs, active devices, iOS-version distribution, retention 2021–23 · https://appstoreconnect.apple.com → App Analytics | Your login. Decides the 2.0 deployment target (currently iOS 17, unverified against real installed base) and is the main evidence for the reposition-vs-sunset call. Read retention knowing the 50-second background bug was capping it. | ~10 min | Phase 2 decision; deployment-target lock |
| 3 | **Decide Dan's role** — co-decider on reposition-vs-sunset, or courtesy consult? | Changes *when* he gets looped in, not just what he sees. If co-decider, he should see the 2.0 direction before it hardens, not after. | a judgment call | the Dan proposal's timing |
| 4 | **Rename `~/Development/OptiListen` → `optilisten-site` on Amber** | It correctly tracks `Design-in-Product/optilisten` (the live marketing site), but the bare name reads as the app. Pard found it and left it alone — not his directory. | ~30 sec | nothing; defuses a trap |

## In flight

| Owner | Item | Waiting on |
|---|---|---|
| **Pard** | Set `DEVELOPMENT_TEAM = YZ4B34YGX9`, `xcodegen generate`, first build/archive on Amber | Nothing — unblocked as of 2026-09-07 |
| **Pard → Cairn** | Send **raw compiler errors**, not fixes. `LiveMicSource.swift` is the least-certain file: the `AVAudioEngine` tap crossing into `@MainActor` state, and the `nonisolated` `rmsDecibels` static, under Swift 6 strict concurrency | the first build |
| **Pard** | Test whether automatic signing provisions on its own before anyone opens the developer portal | the first archive attempt |
| **Janus** | Registry: two entries, not one — `mediajunkie/optilisten` (the app, Cairn) and `Design-in-Product/optilisten` (the live site, no owner) | memo sent 2026-09-07 |
| **Cairn** | Deferred-reflection resume flow in `HomeView` (currently a placeholder); mine `RecordSession.tsx` + the voice patch for how 1.x actually did speaker discrimination | not blocked |
| **open** | Whether Cairn runs as Cowork or Code, and on which machine | xian; not urgent |

## Closed since 2026-09-05

| Item | Resolution |
|---|---|
| **Where is the 1.x source?** | `AustinWood/listenup-mobile` — private, Austin's personal account. xian's `mediajunkie` login already had read access; it was never lost, just filed under another name and owner. |
| **Upgrade or rewrite?** | Rewrite. RN 0.66.0 / React 17.0.2 with `patches/react-native+0.66.0.patch` — the framework itself was patched to make the app work. Those patches can't apply to anything newer. |
| **Xcode blocker on Amber** | Never existed. Amber has Xcode 26.6 / iOS 26.5 SDK. Cairn measured kindbook and reported it as Amber; corrected 2026-09-06. |
| **Whose Apple team owns the App Store record?** | xian's — `Seller: Christian Crumlish`, `DEVELOPMENT_TEAM = YZ4B34YGX9`. He created the identifier and app record himself in Aug 2022 and has carried the membership since. No transfer, no paperwork. |
| **Which repo does 2.0 live in?** | `mediajunkie/optilisten`. Took over the dormant static-site repo; old site preserved at `a639400`. |

## Standing risks

- **None of the 2.0 SwiftUI has ever been compiled.** Written without a Swift toolchain for SwiftUI. This is the top risk and it is Cairn's, not Pard's.
- **The app has been rejected by Apple once before**, in July 2023, specifically over background modes. 2.0 omits `UIBackgroundModes` deliberately, but expect scrutiny in that area.
- **Age-rating social-media questions** must be answered at submission (~10 min in App Store Connect). Not a deadline, a gate. Answers are "no" across the board.
