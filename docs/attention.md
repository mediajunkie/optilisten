# OptiListen — what needs xian

**Maintained by:** Cairn · **Updated:** 2026-09-10 (rev 8) · **Deadline:** 2026-11-24 (75 days · day 15 of 90 — unverified, see item 2)

Canonical state. Janus may summarize this into the cross-project meta-rollup.
Rendered for xian as an artifact — https://claude.ai/code/artifact/54087bd3-f172-494f-b79b-49d3406f5215
(republish that same URL rather than creating a new one). This file is the source; the artifact follows it.

> **rev 7: it compiles.** Pard built OptiListen 2.0 on Amber this evening — the first time any of it
> has been through a compiler. **One error in the whole tree**, and it is fixed and pushed (`b6a6a5b`).
> The project's top standing risk for three days was "none of this has ever been compiled." That is
> effectively over. What replaces it as the critical path is smaller and stranger: **one Apple ID
> sign-in on Amber.**

---

## Needs you

| # | Item | Why it's yours | Cost | Blocking |
|---|---|---|---|---|
| 1 | **Sign into Xcode on Amber** — Xcode → Settings → Accounts → add the Apple ID that owns team `YZ4B34YGX9` | Measured by Pard this evening, three surfaces deep. Amber holds the **signing certificates** (`Apple Distribution: Christian Crumlish (YZ4B34YGX9)`) but **no Apple account**: `xcodebuild -allowProvisioningUpdates` fails with `No Accounts: Add a new account in Accounts settings`, and `DVTDeveloperAccountManagerAppleIDLists` reads empty. Certificates let you sign with a profile you already have; an account is what *mints* one. One Job builds only because it holds profiles minted back in August for `co.onejob.deck` — `com.optilisten.ios` has none and cannot get one without an account. Nobody but you can type that password. | ~2 min | archive → TestFlight → the prototype Dan holds → the submission that cancels the 24 Nov removal |
| 2 | **Forward Apple's mail to a mailbox an agent can read** | Unchanged from rev 6. Apple writes to `xian@pobox.com`. The Gmail I can read holds Apple-domain mail from 2022 and a 2024 calendar invite, but **no App Store Connect mail in 2026** except the One Job notice you forwarded by hand on 09-09. Until a pobox→Gmail rule exists for `@email.apple.com`, **no run can ever learn** if Apple moves the date, extends it, or answers a submission. | ~3 min | verification of the only hard deadline |

## Resolved this pass

- **Pard is on the build, and rev 6's item 1 is closed without you having to send the message.** He picked it up himself and owned the two-day gap plainly. Three memos in one evening: the build, the signing answer, and a self-correction retracting a claim in his own previous memo.
- **The unattended fire is proven.** rev 6 said "tonight's 23:06 UTC fire is the real test." This *is* that fire — scheduled, no one at the keyboard — and it reached kindbook's shell, rebased both repos, pushed two commits to two repos and rewrote this file. The 09-08 cloud-only failure mode has not recurred. Nothing further needed here.
- **The `optilisten` / `OptiListen` checkout collision.** Renamed on Amber, and worse than flagged: macOS is case-insensitive, so my suggested lowercase name resolved to the *same directory* as the site checkout and Pard's first clone silently no-opped into it. Now `optilisten-site` (marketing) and `optilisten` (2.0).

## In flight

| Owner | Item | Waiting on | Since |
|---|---|---|---|
| **Pard** | **Rebuild against `b22f06b`** (CalibrationView:127 — source now owns its calibration via `applyCalibration`). `b6a6a5b` already holds. If another error is behind it, send it raw. | the fix, pushed 2026-09-10 08:11 PT; memo sent 08:3x | 2026-09-10 |
| **Pard** | Archive attempt, once an account exists on Amber | item 1 above | 2026-09-09 |
| **Janus** | Registry: two entries, not one — `mediajunkie/optilisten` (the app, Cairn) and `Design-in-Product/optilisten` (the live site, no owner). Pard's 09-07 log says the app path was repointed; whether the site kept its own entry is unconfirmed | memo sent 2026-09-07 | 2026-09-07 |
| **Cairn** | Deferred-reflection resume flow in `HomeView`, currently a placeholder — the mechanic that makes "Later" mean something other than "abandoned"; mine `RecordSession.tsx` + the voice patch for how 1.x did speaker discrimination | not blocked | 2026-09-06 |
| **Cairn** | **The Dan package** — options (minimally comply / reposition / sunset), a prototype he can hold, and a recommendation. Prototype means a TestFlight build, so it sits downstream of item 1; the recommendation has its baseline in `docs/analytics-2026-09-07.md` | item 1 | 2026-09-06 |
| **open** | Whether Cairn runs as Cowork or Code, and on which machine | xian; not urgent, and less pressing now that the scheduled Cowork run has proven it can reach a Mac and push unattended | 2026-09-06 |

## Closed since 2026-09-05

| Item | Resolution |
|---|---|
| **The 2.0 tree has never been compiled** | Compiled 2026-09-09 on Amber, simulator target with `CODE_SIGNING_ALLOWED=NO`. `PracticeLoopView`, `HomeView`, `OptiListenApp`, `TalkRatioSource`, `CalibrationView`, `RetrospectiveSources` and `Practice` all built clean. One error, below. |
| **The one compiler error** | `LiveMicSource.swift:37` — `@MainActor LiveMicSource` conforming to `LiveTalkRatioSource`, whose `currentShare` and `observedDuration` are nonisolated. **Not the `AVAudioEngine` tap**, which I had flagged and which compiles fine, and not `nonisolated static rmsDecibels`. Fixed at `b6a6a5b` by isolating the two protocol requirements to the main actor rather than isolating the conformance — no Swift 6.2 feature needed under `SWIFT_VERSION 6.0`, and it states the real constraint. **Awaiting Pard's rebuild; I could not compile it.** |
| **Does automatic signing provision on its own?** | **No, and not for the reason expected.** It fails one step before the portal: there is no Apple account on Amber at all. Now item 1. |
| **`DEVELOPMENT_TEAM` in the repo** | It wasn't. Pard set `YZ4B34YGX9` in his working copy; `main` still carried the empty placeholder, so any fresh clone would have regenerated a project with no team. Committed at `b6a6a5b`. |
| **Scheduled mail check unbound to a device** | Fixed and now proven unattended. See "Resolved this pass". |
| **Residual 26.5-SDK worry** | Retired. One Job reached "Pending Developer Release" 2026-09-08 through Amber's Xcode 26.6 / iOS 26.5 toolchain. |
| **Where is the 1.x source?** | `AustinWood/listenup-mobile` — private, on the contractor's personal account. Your `mediajunkie` login already had read access. |
| **Upgrade or rewrite?** | Rewrite. RN 0.66.0 with `patches/react-native+0.66.0.patch` — the framework itself was patched, and those patches can't apply to anything newer. |
| **Xcode blocker on Amber** | Never existed. Cairn measured kindbook and reported it as Amber; corrected 2026-09-06. |
| **Whose Apple team owns the App Store record?** | xian's — `Seller: Christian Crumlish`, team `YZ4B34YGX9`, created Aug 2022. No transfer, no lead time. |
| **Which repo does 2.0 live in?** | `mediajunkie/optilisten`. Old site preserved at `a639400`. |
| **App Store analytics** | 96 lifetime downloads, ~1.3 sessions each, retention nil — but 548 impressions and 5 first-time downloads in the last 30 days with zero marketing. iOS 17 target confirmed. Full read in `docs/analytics-2026-09-07.md`. |
| **Dan's role** | Co-decider, not courtesy consult. He should see the 2.0 direction before it hardens. |

## Standing risks

- **The fix is unverified.** `b6a6a5b` has not been through a compiler — kindbook has no Xcode, and I pushed reasoning rather than a build. It is one line of attribute on each of two protocol requirements, and the blast radius is nil (one conformer, `SourceRegistry` already `@MainActor`, all three views holding the concrete type), but "small and well-argued" is not "compiles."
- **The fleet has exactly one signing path, and it expires 2027-08.** One Job's two cached profiles are the only thing letting anything on Amber archive, and nothing would surface their lapse until it happened. Pard found this while correcting himself. Not urgent; should not be invisible.
- **The 2026-11-24 date has not been re-verified since the original notice.** Apple's mail reaches no mailbox an agent reads. Item 2.
- **The app was rejected by Apple once before**, July 2023, over background modes. 2.0 omits `UIBackgroundModes` deliberately, but expect scrutiny there.
- **Age-rating social-media questions** must be answered at submission (~10 min in App Store Connect). A gate, not a deadline. Answers are "no" across the board.

## Method notes

- **Pard's self-correction, recorded because the mechanism changed.** He reported "provisioning profiles on disk: zero" after checking `~/Library/MobileDevice/Provisioning Profiles/` — the pre-Xcode-16 location. There are two, in `~/Library/Developer/Xcode/UserData/Provisioning Profiles/`, both One Job's. Uncorrected, that would have sent you to the developer portal to mint a profile by hand instead of to a two-minute sign-in. He caught it in the same hour and checked a third surface before re-asserting.
- **I was wrong about the tap.** I predicted `LiveMicSource.swift` by reasoning about audio work crossing actor boundaries; the compiler cleared both suspects I named and objected one level up, at the protocol boundary, in a file I never mentioned. Right file, wrong mechanism — worth recording, because the fix lives in `TalkRatioSource.swift`.
