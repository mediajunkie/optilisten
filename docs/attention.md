# OptiListen — what needs xian

**Maintained by:** Cairn · **Updated:** 2026-09-09 (rev 6) · **Deadline:** 2026-11-24 (76 days, unverified — see item 2)

Canonical state. Janus may summarize this into the cross-project meta-rollup.
Rendered for xian as an artifact — https://claude.ai/code/artifact/54087bd3-f172-494f-b79b-49d3406f5215
(republish that same URL rather than creating a new one). This file is the source; the artifact follows it.

> **rev 6 reconciles a split.** The artifact had been carried to rev 5 while this file still read rev 3, so the 16:00 PT run wrote a rev 4 that was behind the page and contained a wrong claim (below). Rev 6 merges both and the two are back in sync.

---

## Needs you

| # | Item | Why it's yours | Cost | Blocking |
|---|---|---|---|---|
| 1 | **Get Pard onto the first build** | Unblocked since 2026-09-07 — team ID resolved, Xcode 26.6 and the iOS 26.5 SDK present on Amber, nothing waiting on anyone. Two days on: no reply to the memos, and Pard's logs for 09-08 and 09-09 carry no OptiListen entry at all. Nothing is wrong — it simply hasn't been picked up, and Pard takes priority from you, not from me. A memo from me is a request; a word from you is a priority. The clone-and-build command is already in his mailbox (`memo-cairn-to-pard-repo-provenance-and-your-amber-clone-2026-09-07.md`). | one message | the first compile, and everything behind it |
| 2 | **Forward Apple's mail to a mailbox an agent can read** | Apple writes to `xian@pobox.com`. **Measured this pass:** the Gmail I can read holds Apple-domain mail from 2022 (D-U-N-S, developer program) and a 2024 calendar invite, but **no App Store Connect mail in 2026** — the only 2026 item is the One Job notice you forwarded by hand on 09-09. So the 2026-08-26 removal notice never reached a mailbox any run can see, and the 2026-11-24 date is carried from your screenshot. Until a pobox→Gmail rule exists for `@email.apple.com`, **no run can ever learn** if Apple moves the date, extends it, or answers a submission. | ~3 min | verification of the only hard deadline |

## Resolved this pass

- **The scheduled mail check now reaches the Mac.** Rev 3's "needs you" item is done. The task is `trig_01PvG2hYtP3DaToGCs5qxsRE` (`0 15,23 * * *` = 08:00 and 16:00 PT). The 09-08 fires ran **cloud-only** — that run measured the consequences precisely: no `remote-devices` tools at all, and the cloud container read-only and public-repos-only (Cairn's own mailbox readable by anonymous clone; Pard's private mailbox `403`; GitHub API `403` with and without a token; push refused even with `GH_TOKEN` explicit). **Verified this run:** reached kindbook's shell, fetched and rebased both repos, wrote this file, and pushed to `origin main`. **Not yet verified:** that an *unattended* fire carries the same access — this firing was manual (21:32 UTC, off-cron, one minute after the task was updated). Tonight's 23:06 UTC fire is the real test, and it needs nothing from you either way.

## In flight

| Owner | Item | Waiting on | Since |
|---|---|---|---|
| **Pard** | Clone on Amber, set `DEVELOPMENT_TEAM = YZ4B34YGX9`, `xcodegen generate`, first build/archive | Nothing — unblocked | 2026-09-07 (2 days, no entry in Pard's logs) |
| **Pard → Cairn** | Send **raw compiler errors**, not fixes. `LiveMicSource.swift` first: the `AVAudioEngine` tap crossing into `@MainActor` state, and the `nonisolated` `rmsDecibels` static, under Swift 6 strict concurrency | the first build | 2026-09-07 |
| **Pard** | Test whether automatic signing provisions on its own before anyone opens the developer portal. Amber has no profiles, but automatic signing mints them on demand and One Job already builds there | the first archive attempt | 2026-09-07 |
| **Pard** | Rename `~/Development/OptiListen` → `optilisten-site` on Amber — xian approved; state unknown | nothing | 2026-09-07 |
| **Janus** | Registry: two entries, not one — `mediajunkie/optilisten` (the app, Cairn) and `Design-in-Product/optilisten` (the live site, no owner). Pard's 09-07 log says the app path was repointed; whether the site kept its own entry is unconfirmed | memo sent 2026-09-07 | 2026-09-07 |
| **Cairn** | Deferred-reflection resume flow in `HomeView`, currently a placeholder — the mechanic that makes "Later" mean something other than "abandoned"; mine `RecordSession.tsx` + the voice patch for how 1.x did speaker discrimination | not blocked; compile errors take priority when they land | 2026-09-06 |
| **Cairn** | **The Dan package** — options (minimally comply / reposition / sunset), a prototype he can hold, and a recommendation. Prototype means a TestFlight build, so it sits downstream of Pard's first build; the recommendation has its baseline in `docs/analytics-2026-09-07.md` | first build | 2026-09-06 |
| **open** | Whether Cairn runs as Cowork or Code, and on which machine | xian; not urgent. The 09-08 cloud-only measurement is one more data point for the Code-agent-on-Amber side | 2026-09-06 |

## Closed since 2026-09-05

| Item | Resolution |
|---|---|
| **Scheduled mail check unbound to a device** | Fixed. Reaching kindbook as of 2026-09-09; unattended fire still to be confirmed. See "Resolved this pass". |
| **Residual 26.5-SDK worry** | Retired. One Job reached "Pending Developer Release" 2026-09-08 through Amber's Xcode 26.6 / iOS 26.5 toolchain — a live Apple acceptance from this same team, this week. (The build SDK is Pard's claim; the approval date is measured.) |
| **Where is the 1.x source?** | `AustinWood/listenup-mobile` — private, on the contractor's personal account. xian's `mediajunkie` login already had read access; never lost, just filed under another name and owner. |
| **Upgrade or rewrite?** | Rewrite. RN 0.66.0 / React 17.0.2 with `patches/react-native+0.66.0.patch` — the framework itself was patched to make the app work, and those patches can't apply to anything newer. |
| **Xcode blocker on Amber** | Never existed. Amber has Xcode 26.6 / iOS 26.5 SDK. Cairn measured kindbook and reported it as Amber; corrected 2026-09-06. |
| **Whose Apple team owns the App Store record?** | xian's — `Seller: Christian Crumlish`, `DEVELOPMENT_TEAM = YZ4B34YGX9`. He created the identifier and app record in Aug 2022 and has carried the membership since. No transfer, no paperwork, no lead time. |
| **Which repo does 2.0 live in?** | `mediajunkie/optilisten`. Took over the dormant static-site repo; old site preserved at `a639400`. |
| **App Store analytics** | Pulled 2026-09-07, full read in `docs/analytics-2026-09-07.md`. 96 lifetime downloads, ~1.3 sessions each, retention nil — but 548 impressions and 5 first-time downloads in the last 30 days with zero marketing. Deployment target iOS 17.0 confirmed; every download since 2024 is on 17+. The demand side has a pulse; the product side flatlined. |
| **Dan's role** | Owner, and very likely to take xian's advice — co-decider, not courtesy consult. He should see the 2.0 direction before it hardens rather than after it ships. |

## Standing risks

- **None of the 2.0 SwiftUI has ever been compiled.** Written without a Swift toolchain for SwiftUI. This is the top risk, it is Cairn's, and it has now sat untested for three days for want of a build.
- **The 2026-11-24 date has not been re-verified since the original notice.** Apple's mail doesn't reach any mailbox an agent reads. Item 2.
- **The app has been rejected by Apple once before**, July 2023, specifically over background modes. 2.0 omits `UIBackgroundModes` deliberately, but expect scrutiny there.
- **Age-rating social-media questions** must be answered at submission (~10 min in App Store Connect). A gate, not a deadline. Answers are "no" across the board.

## Checked this pass, unchanged

- **Mailbox quiet.** Nothing new in `docs/mail/` since the two Pard memos of 2026-09-07, both already answered (`memo-cairn-to-pard-team-ownership-resolved`, `memo-cairn-to-pard-repo-provenance-and-your-amber-clone`, both delivered to `mediajunkie/mediajunkie`). No memo sent this pass.
- **Correction, same day.** Rev 4 (written 30 minutes before this one) said "No Apple mail in the last 14 days — the 2026-11-24 removal date has not moved," presenting a search of the wrong mailbox as verification of the deadline. **Retracted.** Apple does not write to that Gmail; absence there is not absence in the world. The date stands where it stood — carried from the screenshot, unverified — and that is now item 2 rather than a reassurance.
