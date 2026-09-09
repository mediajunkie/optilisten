# OptiListen — what needs xian

**Maintained by:** Cairn · **Updated:** 2026-09-09 (rev 5 — merges the 09-08 scheduled run's artifact-only rev 4) · **Deadline:** 2026-11-24 (76 days · day 14 of 90)

Canonical state. Janus may summarize this into the cross-project meta-rollup.
Rendered for xian as an artifact — https://claude.ai/code/artifact/54087bd3-f172-494f-b79b-49d3406f5215
(republish that same URL rather than creating a new one). This file is the source; the artifact follows it.

---

## Needs you

| # | Item | Why it's yours | Cost | Blocking |
|---|---|---|---|---|
| 1 | **Get Pard onto the first build.** Nothing has moved on the app since 09-07: no reply to three memos, no clone on Amber, no `DEVELOPMENT_TEAM` set, no build attempted. Pard's 09-08/09 logs are all other work. | Pard runs on a duty cycle and takes priority from you, not me. A memo from me is a request; a word from you is a priority. The clone-and-build command is one line in `memo-cairn-to-pard-repo-provenance-and-your-amber-clone-2026-09-07.md`. | one message to Pard | **everything downstream** — the compile is the top risk and it hasn't been tried |
| 2 | **Forward Apple's mail where an agent can see it.** Apple writes to `xian@pobox.com`; the Gmail I read never received the 08-26 notice. A pobox→Gmail rule for `@email.apple.com`, or a habit of forwarding OptiListen App Store mail by hand (as you did for One Job on 09-08). | Your accounts. Until then the 11-24 date is carried from your screenshot and **no run can ever learn** if Apple moves it, extends it, or answers a submission. | ~3 min | deadline verification; review-result visibility |
| 3 | **Re-approve the scheduled mail check so it binds to a computer.** Fired 09-08 and 09-09 cloud-only: read my public mailbox, couldn't push the rollup, couldn't read Pard's private repo, couldn't send mail. A binding can't be added after creation — delete and recreate from a desktop session. | Needs the device prompt answered on the linked computer. Not visible on mobile. | ~2 min at a desktop | the async mail loop — until then I only see mail when you open a session |

## In flight

| Owner | Item | State |
|---|---|---|
| **Pard** | Clone `mediajunkie/optilisten` to Amber, set `DEVELOPMENT_TEAM = YZ4B34YGX9`, `xcodegen generate`, first build → **raw compiler errors to Cairn** | **not started** as of 09-09; unblocked since 09-07 |
| **Pard** | Test automatic signing before anyone opens the developer portal | waits on the build |
| **Pard** | Rename `~/Development/OptiListen` → `optilisten-site` on Amber (xian approved 09-07) | unknown |
| **Janus** | Registry: `mediajunkie/optilisten` (app, Cairn) + `Design-in-Product/optilisten` (live site) | Pard's 09-07 log says the app path was repointed; whether the site kept its own entry is unconfirmed |
| **Cairn** | Deferred-reflection resume flow in `HomeView`; mine `RecordSession.tsx` for 1.x speaker discrimination | can proceed without the build, but compile errors take priority when they land |
| **Cairn** | **The Dan package** — options (minimally comply / reposition / sunset), a TestFlight prototype, a recommendation. Baseline is in `docs/analytics-2026-09-07.md` | prototype waits on the build |
| **open** | Whether Cairn runs as Cowork or Code, and on which machine | xian; not urgent |

## Closed since 09-07

- **Residual SDK worry retired.** One Job reached "Pending Developer Release" on 09-08 through (per Pard) Amber's Xcode 26.6 / iOS 26.5 SDK. A live acceptance from this account, this week. Build SDK is Pard's claim; the approval date is measured.
- **Analytics pulled** (09-07). 96 lifetime downloads, ~1.3 sessions each, retention nil; 548 impressions and 5 first-time downloads in the last 30 days with zero marketing. **iOS 17 deployment target confirmed.**
- **Dan is co-decider.** Owns OptiListen, likely to take xian's advice; the package goes to him with a recommendation attached.
- **Team ownership** (09-07): the App Store record is xian's — `Seller: Christian Crumlish`, `YZ4B34YGX9`. No transfer.
- **Cloud-only runs are read-only on public repos** — confirmed three times, including with `GH_TOKEN` explicit. The proxy names an `add_repo` mechanism that Cowork doesn't expose; binding is environment-level, Pard's lane. Same wall as Wren's.

## Standing risks

- **None of the 2.0 SwiftUI has ever been compiled.** Top risk, mine, and it's now been sitting untested for three days for want of a build.
- **Apple has rejected this app once before** (July 2023, background modes). 2.0 omits `UIBackgroundModes` deliberately; expect scrutiny there.
- **The 11-24 date is unverified since the original notice** — see item 2.
- **Age-rating social-media questions** at submission; ~10 min; answers are "no."
