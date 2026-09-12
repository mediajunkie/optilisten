# OptiListen — what needs xian

**Maintained by:** Cairn · **Updated:** 2026-09-12 (rev 15) · **Deadline:** 2026-11-24 (73 days · day 17 of 90 — carried from the 08-26 notice; the Apple-mail forward is live, so the next App Store Connect mail settles it)

Canonical state. Janus may summarize this into the cross-project meta-rollup.
Rendered for xian as an artifact — https://claude.ai/code/artifact/54087bd3-f172-494f-b79b-49d3406f5215
(republish that same URL rather than creating a new one). This file is the source; the artifact follows it.
The artifact's HTML source lives beside this file at `docs/attention.html`.

> **rev 15: 2.0 is in TestFlight, and the first build crashes.** On 09-11 Pard shipped **2.0 (1)** to
> App Store Connect unattended — no desk, no sign-in — by switching `exportOptions` from automatic
> (which means *cloud* signing, the account wall) to manual, pinned to a distribution profile the
> App Store Connect API minted (`UL843FQA32`). Delivery `a5d9eccf`. It processed; xian installed it;
> **it dies on Start.** Cause known before it happened: every `INFOPLIST_KEY_*` setting was dead
> because the project uses an explicit Info.plist, and the microphone usage string — the one the
> validator can't catch — was missing from that build. Fixed on `main` at `99a34bc`, after the
> upload. **2.0 (2) requested.** Separately: Dan found the update note too thick with jargon, so
> there's now a plain-language page for him, published and versioned in `docs/for-dan/`.

---

## Needs you

| # | Item | Why it's yours | Cost | Blocking |
|---|---|---|---|---|
| 1 | **Share the Dan page** — from the artifact's share menu, it's private until you do. | It's written as you, for him: the idea in three moments, the four screens drawn from the app's real copy, honest built/not-built columns (including the crash), the numbers, the three options, two asks. No agent names, no toolchain. | ~1 min | Dan's reaction — the input the recommendation needs |
| 2 | **Tap Share on the crash sheet** the next time 2.0 (1) dies, so the report reaches App Store Connect. Then leave (1) alone until (2) is up. | Confirms the termination reason reads as the missing-usage-string kill, not something else. You've already warned Dan off; keep it that way until (2). | ~10 sec | nothing — confirmation only |

## Resolved this pass

- **The archive → TestFlight path is proven, unattended, end to end.** `automatic` signing in `exportOptions.plist` means *cloud signing*, which needs the interactive account — that was the entire wall. `manual`, pinned to an API-minted distribution profile, exports and uploads from SSH with nobody at a desk. Coral's `AMBER-XCODE.md` was the map; Pard walked it in a morning. The "account absent / re-add / which session" thread is closed and moot: **the shipping path never needed the account visible.**
- **The `INFOPLIST_KEY_*` class, fully accounted.** Four keys were silently absent from every bundle ever built: orientations and launch screen (caught by Apple's validator at upload, 90474/90475), the app icon (90023 — the 2.0 tree had no asset catalog; Pard recovered the original 1.x icon from Apple's CDN), and **`NSMicrophoneUsageDescription`** (never caught by the validator; caught by xian's phone). All keys now live under `info.properties` with a comment forbidding the `INFOPLIST_KEY_` form while `info.path` exists.
- **The crash is diagnosed, not investigated.** iOS terminates any process on first microphone access without the usage string — no error, just gone. 2.0 (1) was built before the fix. Build bumped to 2 at `4787b85`.
- **The Dan page exists** — `docs/for-dan/what-optilisten-does-now.html`, artifact `98ea8355…`. The email he found jargon-thick was written for xian and read by Dan; this was written for Dan.
- **Apple mail forward verified live** (09-11): a `no_reply@email.apple.com` message reached the readable mailbox. The removal date is still carried from the 08-26 screenshot — that notice predates the forward — but the channel works, and Pard notes a fresh build often resets removal clocks, so it's worth checking in ASC.

## In flight

| Owner | Item | Waiting on |
|---|---|---|
| **Pard** | **Archive + upload 2.0 (2)** on the manual-signing / API path. Before upload: `plutil -p` the built bundle's Info.plist and confirm `NSMicrophoneUsageDescription`, `UILaunchScreen`, `UISupportedInterfaceOrientations`, `CFBundleDisplayName` are *in the artifact*, not just in `project.yml`. | nothing — memo sent 09-12 |
| **Pard** | Re-check the removal date in App Store Connect now that a build has been accepted — does the grace-period notice still show 11-24, or did the upload clear it? | the 2.0 (2) upload is a natural moment |
| **Pard** | Empty-account-list drift guard for Amber — lower priority now; the check should distinguish *absent* from *not visible from this session* | not blocked |
| **Cairn** | Once 2.0 (2) is up and xian confirms Start works: **update the Dan page** — remove the crash line from "Not there yet," tell Dan it's safe to try | (2) processed + xian's confirmation |
| **Cairn** | Deferred-reflection resume flow in `HomeView` (placeholder); calibration persistence; mine `RecordSession.tsx` for 1.x speaker discrimination | not blocked; (2) first |
| **Cairn** | **The Dan package** — three options, a prototype he can hold, a recommendation. The prototype is one working build away; the recommendation waits on his reaction to the page and the build | (2), then Dan |
| **Janus** | Registry: two entries — `mediajunkie/optilisten` (app) and `Design-in-Product/optilisten` (live site) | memo 09-07; unconfirmed |
| **open** | Whether Cairn runs as Cowork or Code, and on which machine | xian; not urgent — six unattended fires have now reached a Mac and pushed |

## Standing risks

- **Compiling is not running, and running is not being used.** 2.0 has now been launched on a real phone exactly once and died on the first tap. (2) is the first build that can be *used*. Nobody has watched the calibration, the mic tap, or the loop behave in a real conversation.
- **Calibration is `Codable` and nothing persists it** — the user recalibrates every cold launch. Folded into the `HomeView` work.
- **The fleet has one signing path and it expires Aug 2027.** One Job's cached profiles plus the API-minted one for OptiListen. The API path can renew them, which is better than a week ago, but nothing watches for expiry.
- **The 24 Nov date is still the screenshot, not an ASC readback.** The forward works; nobody has looked.
- **Apple has rejected this app once before** (July 2023, background modes). 2.0 omits `UIBackgroundModes`; expect scrutiny.
- **Age-rating social-media questions** at submission; ~10 min; answers are "no."
