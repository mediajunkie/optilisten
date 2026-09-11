# OptiListen — what needs xian

**Maintained by:** Cairn · **Updated:** 2026-09-11 (rev 14) · **Deadline:** 2026-11-24 (74 days — forward now verified live; re-verify on Apple's next App Store Connect mail)

Canonical state. Janus may summarize this into the cross-project meta-rollup.
Rendered for xian as an artifact — https://claude.ai/code/artifact/54087bd3-f172-494f-b79b-49d3406f5215
(republish that same URL rather than creating a new one). This file is the source; the artifact follows it.
The artifact's HTML source lives beside this file at `docs/attention.html`, so a run edits it rather than retyping it.

> **rev 14: the archive exists.** Pard built it on Amber, unattended, with no Xcode account session
> at all — an App Store Connect API key does `archive` and `-exportArchive` on its own, which Coral
> had already proven live on One Job in August and documented in `one-job/docs/AMBER-XCODE.md`.
> `build/OptiListen.xcarchive` · `com.longskymedia.optilisten` · **2.0 (1)** · signed. **Everything
> upstream of distribution is done.** What is left is one artifact that does not yet exist: a
> *distribution* provisioning profile for this bundle ID. Three paths to it, one of which may not
> need xian at all — item 1.

---

## Needs you

| # | Item | Why it's yours | Cost | Blocking |
|---|---|---|---|---|
| 1 | **Mint a distribution profile for `com.longskymedia.optilisten` — once.** The archive is built and signed; export to TestFlight fails at `No profiles for 'com.longskymedia.optilisten' were found`, exactly where Coral's did in August. Three ways, cheapest first: **(a) Pard tries the API** — Apple documents that the App Manager role *can* generate distribution credentials when *Access to Certificates, Identifiers, and Profiles* is enabled, so `GET /v1/profiles` with the existing key tests it for free, and `POST /v1/profiles` mints it if the key can reach that surface. Needs nobody at a desk. **(b) A second API key at Admin role** — App Store Connect → Users and Access → Integrations, ~2 min, keeps the unattended property. **(c) You, at the desk** — Xcode → Window → Organizer → select the archive → Distribute App → TestFlight, ~5 min, guaranteed to work. **(a) is running; only do (c) if you want it done today rather than next cycle.** | (a) free, Pard's · (b) ~2 min · (c) ~5 min | export → TestFlight → Dan's prototype |

## Resolved this pass

- **"Archive from the GUI so the account is visible" — superseded, and the reasoning was beside the point.** The archive did not need a visible Apple account. An App Store Connect API key (`AuthKey_D96QY6RRB3`, live since 08-08) archives unattended and even **auto-created a development provisioning profile for the corrected bundle ID on the fly**. Coral's `AMBER-XCODE.md`, proven live 2026-08-16, is why this took Pard twenty minutes instead of a day: *"it only needed elevated privilege to create them, not to use them."* The interactive account is needed once per bundle ID, to **create** the distribution profile — not to build, not to archive, not to sign.
- **My version/build all-clear was wrong, and Pard caught it by reading the artifact.** I verified `project.yml` — `MARKETING_VERSION = 2.0`, `CURRENT_PROJECT_VERSION = 1` — and reported the class clear. He read the built archive: `CFBundleShortVersionString = 1.0` against a shipped `1.3`. **An upload-time rejection, exactly the class I went looking for, hiding one layer below where I looked.** Root cause: `project.yml`'s `info.properties` set only `ITSAppUsesNonExemptEncryption`, so xcodegen wrote its own `1.0`/`1` defaults into the generated Info.plist — **and the plist wins over the build settings.** Both files were individually correct; the wiring between them didn't exist. Fixed by Pard, wired `CFBundleShortVersionString: "$(MARKETING_VERSION)"` / `CFBundleVersion: "$(CURRENT_PROJECT_VERSION)"`, re-archived, **verified by reading `2.0` back out of the rebuilt artifact**. Confirmed on `main` by `git show HEAD:project.yml`.
- **The pobox→Gmail forward is verified working, not just configured.** A message from `no_reply@email.apple.com` dated **2026-09-11 13:28 UTC** is in the readable mailbox. It is a purchase receipt rather than App Store Connect mail — but it proves the Apple-domain path end to end, which had been untested since the forward went in on 09-10. From here, a deadline change or a review result is visible to a scheduled run.
- **The 2026-11-24 date is still carried, not confirmed.** No App Store Connect mail about OptiListen's removal is in that mailbox, and **absence is not confirmation** — the 08-26 notice predates the forward and was never going to be there. The date remains xian's screenshot. What changed is that the channel now works, so the next Apple mail settles it.
- **`exportOptions.plist` is in the repo** (`c0d94cc`), mirroring One Job's live-proven config, so the export is one stable reviewable command rather than a reconstruction from `/tmp`.
- **"The account is absent" — retracted, and stays retracted.** `xian@pobox.com` is present. Pard found `"acct"<blob>="xian@pobox.com"` in a broad keychain dump while drafting a reply: his three "agreeing" checks all read service names Xcode doesn't use and a plist key the account doesn't live in — three readings, one vantage point, zero independence. Since Xcode 9.3 the credentials live in the *local items* keychain, which an SSH/Background session cannot read. **A headless session on Amber can report "not visible from here," never "absent."**
- **The 403 on scheduled cloud sessions is not Pard's to fix.** Amber has no `GH_TOKEN` and authenticates over SSH, so nothing host-side is upstream of the container. Back with xian as an account-side question; it has not bitten since these fires started reaching kindbook.

## In flight

| Owner | Item | Waiting on | Since |
|---|---|---|---|
| **Pard** | **Test whether the existing API key can mint the distribution profile** — `GET /v1/profiles`, then `POST` if it reads. If it 403s, the GUI step is a real per-bundle-ID cost and goes in the harbor manifest as one | memo sent 2026-09-11 | 2026-09-11 |
| **Pard** | **Export to TestFlight and hand over the build** — same hour the profile exists. The archive is already sitting at `~/Development/optilisten/build/OptiListen.xcarchive` | item 1 | 2026-09-09 |
| **Pard** | **Add an empty-account-list check to Amber's drift-checked guards.** Lower priority than it looked yesterday — the account was never absent — but a check that distinguishes *absent* from *invisible to this session* is still worth having | not blocked | 2026-09-10 |
| **Coral** | Whether a distribution profile can be created without the interactive session, and whether One Job's 2027-08 renewal takes the same Admin path | memo cc'd 2026-09-10, re-asked 2026-09-11 | 2026-09-10 |
| **Janus** | Registry: two entries, not one — `mediajunkie/optilisten` (the app, Cairn) and `Design-in-Product/optilisten` (the live site, no owner) | memo sent 2026-09-07 | 2026-09-07 |
| **Cairn** | Deferred-reflection resume flow in `HomeView`, currently a placeholder — the mechanic that makes "Later" mean something other than "abandoned"; mine `RecordSession.tsx` + the voice patch for how 1.x did speaker discrimination. Calibration persistence folds into this | not blocked | 2026-09-06 |
| **Cairn** | **The Dan package** — options (minimally comply / reposition / sunset), a prototype he can hold, and a recommendation. Prototype means a TestFlight build, so it sits downstream of item 1; the recommendation has its baseline in `docs/analytics-2026-09-07.md` | item 1 | 2026-09-06 |
| **open** | Whether Cairn runs as Cowork or Code, and on which machine | xian; not urgent, and less pressing now that the scheduled Cowork run has proven it can reach a Mac and push unattended across five fires | 2026-09-06 |

## Closed since 2026-09-05

| Item | Resolution |
|---|---|
| **Does the archive need an interactive Apple account?** | **No.** An App Store Connect API key archives unattended and auto-provisions a development profile. Only *distribution* profile creation needs the elevated path, once per bundle ID. |
| **The archive itself** | **Built 2026-09-10 on Amber.** `com.longskymedia.optilisten`, 2.0 (1), signed, unattended. |
| **Version/build collision at upload** | Real after all, and fixed. The spec was right; the *artifact* carried 1.0 because xcodegen's Info.plist defaults beat the build settings. Wired through, re-archived, read back as 2.0 (1). |
| **Which macOS session archived One Job?** | Moot — no session did the OptiListen archive; the API key did. Coral's runbook had the mechanism documented since August. |
| **The 2.0 tree has never been compiled** | Compiled 2026-09-09, green end to end 2026-09-10. |
| **Error 1 — `LiveMicSource.swift:37`** | `@MainActor LiveMicSource` conforming to `LiveTalkRatioSource`, whose `currentShare` and `observedDuration` were nonisolated. Fixed at `b6a6a5b`. **Verified by rebuild.** |
| **Error 2 — `CalibrationView.swift:127`** | `source.calibration = calibration` against a `private(set)` setter. Fixed at `b22f06b` by adding `applyCalibration(userLevel:ambientLevel:)` rather than opening the setter. **Verified 2026-09-10**, with `b22f06b` confirmed as an ancestor of the built HEAD before reporting. |
| **The 2.0 tree compiles clean, end to end** | `** BUILD SUCCEEDED **` on Amber 2026-09-10 — 1,151 lines, Swift 6 `SWIFT_STRICT_CONCURRENCY: complete`, zero errors, zero warnings, iOS 26.5 SDK. |
| **The wrong bundle ID** | `com.longskymedia.optilisten`, from the 1.x `project.pbxproj`. Fixed `73f2b95`, comment cleaned `ba1023c`, verified in the generated project and now in the archive. |
| **Bundle-ID ownership** | A naming convention with no bearing on team ownership. Registered to `YZ4B34YGX9`. Dan's Apple ID is not involved. |
| **Apple mail reaching a readable mailbox** | Forward set up 09-10, **verified carrying Apple-domain mail 09-11**. |
| **`DEVELOPMENT_TEAM` in the repo** | Committed at `b6a6a5b`; both copies agree. |
| **Scheduled mail check unbound to a device** | Proven unattended across five fires, each reaching kindbook's shell, rebasing both repos and pushing. |
| **Residual 26.5-SDK worry** | Retired. One Job reached "Pending Developer Release" 2026-09-08 through Amber's Xcode 26.6 / iOS 26.5 toolchain. |
| **Where is the 1.x source?** | `AustinWood/listenup-mobile` — private, on the contractor's personal account. Your `mediajunkie` login already had read access. |
| **Upgrade or rewrite?** | Rewrite. RN 0.66.0 with `patches/react-native+0.66.0.patch` — the framework itself was patched. |
| **Xcode blocker on Amber** | Never existed. Cairn measured kindbook and reported it as Amber; corrected 2026-09-06. |
| **Whose Apple team owns the App Store record?** | xian's — `Seller: Christian Crumlish`, team `YZ4B34YGX9`, created Aug 2022. |
| **Which repo does 2.0 live in?** | `mediajunkie/optilisten`. Old site preserved at `a639400`. |
| **App Store analytics** | 96 lifetime downloads, ~1.3 sessions each, retention nil — but 548 impressions and 5 first-time downloads in the last 30 days with zero marketing. iOS 17 target confirmed. |
| **Dan's role** | Co-decider, not courtesy consult. |

## Standing risks

- **Compiling is not running, and archiving is not running either.** The tree builds clean and now archives clean; nobody has yet watched it *behave* — the mic tap, the calibration flow, the practice loop under a real conversation. TestFlight is where that gets answered, which is why item 1 is still the whole critical path.
- **Calibration is `Codable` and nothing persists it.** The user recalibrates from scratch on every cold launch. Folded into the `HomeView` work.
- **The fleet's signing path expires 2027-08, and renewal takes the same elevated route as item 1.** One Job's profiles are dated; whatever resolves item 1 should be written down as the renewal procedure rather than rediscovered next August.
- **The 2026-11-24 date has not been re-verified since the original notice.** The channel to verify it now works.
- **The app was rejected by Apple once before**, July 2023, over background modes. 2.0 omits `UIBackgroundModes` deliberately, but expect scrutiny there.
- **Age-rating social-media questions** must be answered at submission (~10 min in App Store Connect). A gate, not a deadline. Answers are "no" across the board.

## Method notes

- **Read the shipped artifact, not the spec that describes it — and that now has a checklist.** Before any archive is called ready: **version, bundle ID and signing identity, read out of the `.xcarchive` itself.** All three have been wrong at least once while the spec looked correct. Pard's rule, adopted. Three defects in two days were found by reading output rather than input, and the third was mine: I checked `project.yml` and declared the version class clear while the built archive carried `1.0`.
- **When one metadata error surfaces, sweep for its siblings.** That instinct was right and found a real defect — but I swept the *specification* for siblings when the first one had been found in an *artifact*. Sweep the same layer the original was found in.
- **"Consistency isn't verification when the vantage point is wrong."** Pard's three checks on the Apple account all agreed and were all wrong the same way — same session, same false assumption about where Xcode stores things. Three readings from one vantage point are one reading. A headless session can report *not visible from here*, never *absent*.
- **A documented workaround may already exist in a sibling project.** The account question consumed two days across both of us; Coral had written the mechanism down in August and proven it live. Checking `one-job/docs/` first would have skipped the entire detour. **Before debugging a signing problem, read what the machine has already shipped.**
- **The instruction is not the artifact.** `com.optilisten.ios` came from an email telling xian what to create. The 1.x project file — the thing that actually shipped — said otherwise the whole time. And when you fix the setting, fix the comment beside it.
- **A commit isn't mail.** Every fix now ships with its memo in the same fire.
- **Two Cairn instances can work this repo inside fifteen minutes.** Read `git log origin/main -- docs/attention.md` and the artifact immediately before writing, and check the recipient's mailbox for a same-day memo from Cairn before sending. Followed this pass; no collision.
