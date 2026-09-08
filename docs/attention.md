# OptiListen — what needs xian

**Maintained by:** Cairn · **Updated:** 2026-09-07 (rev 3) · **Deadline:** 2026-11-24 (78 days)

Canonical state. Janus may summarize this into the cross-project meta-rollup.
Rendered for xian as an artifact — https://claude.ai/code/artifact/54087bd3-f172-494f-b79b-49d3406f5215
(republish that same URL rather than creating a new one). This file is the source; the artifact follows it.

---

## Needs you

| # | Item | Why it's yours | Cost | Blocking |
|---|---|---|---|---|
| 1 | **Re-approve the scheduled mail check so it binds to a computer** | Created 2026-09-07 with `requires_local_device: true`, but returned `not bound: no_signed_approval` — it exists and will fire, cloud-only, where it can neither read Pard's private repo nor push replies. A binding cannot be added after creation, so this one must be deleted and recreated from a session where you can approve the device prompt. Scheduled tasks are not visible on mobile yet. | ~2 min, at a desktop | the async mail loop |

## Resolved this pass

- **App Store analytics pulled** — xian signed in, Cairn extracted. 96 lifetime downloads, ~1.3 sessions each, retention nil, but 548 impressions and 5 first-time downloads in the last 30 days with zero marketing. Full read in `docs/analytics-2026-09-07.md`. **Deployment target iOS 17.0 confirmed** — every download since 2024 is on 17+.
- **Dan's role** — he is the *owner* of OptiListen and very likely to take xian's advice. So: co-decider, not courtesy consult. The reposition-vs-sunset proposal goes to Dan with xian's recommendation attached, and he should see the 2.0 direction before it hardens rather than after it ships.
- **Rename `~/Development/OptiListen` → `optilisten-site` on Amber** — approved by xian; moved to Pard's queue below.

## In flight

| Owner | Item | Waiting on |
|---|---|---|
| **Pard** | Set `DEVELOPMENT_TEAM = YZ4B34YGX9`, `xcodegen generate`, first build/archive on Amber | Nothing — unblocked as of 2026-09-07 |
| **Pard → Cairn** | Send **raw compiler errors**, not fixes. `LiveMicSource.swift` is the least-certain file: the `AVAudioEngine` tap crossing into `@MainActor` state, and the `nonisolated` `rmsDecibels` static, under Swift 6 strict concurrency | the first build |
| **Pard** | Test whether automatic signing provisions on its own before anyone opens the developer portal | the first archive attempt |
| **Pard** | Rename `~/Development/OptiListen` → `optilisten-site` on Amber — xian approved | nothing |
| **Janus** | Registry: two entries, not one — `mediajunkie/optilisten` (the app, Cairn) and `Design-in-Product/optilisten` (the live site, no owner) | memo sent 2026-09-07 |
| **Cairn** | Deferred-reflection resume flow in `HomeView` (currently a placeholder); mine `RecordSession.tsx` + the voice patch for how 1.x actually did speaker discrimination | not blocked |
| **Cairn** | **The Dan package** — xian promised options (minimally comply / reposition / sunset), a prototype, and a recommendation. Prototype means a TestFlight build Dan can hold, so it sits downstream of Pard's first build; the recommendation now has its baseline (`docs/analytics-2026-09-07.md`) | first build |
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
