# OptiListen — Compliance, then Decision

**Status:** Source located. Blocked on access.
**Hard deadline:** 2026-11-24 (79 days from 2026-09-06).
**Owner:** Christian Crumlish. Co-creator: Dan Brodnitz.
**Last updated:** 2026-09-06

---

## Where the code is

**`github.com/AustinWood/listenup-mobile`** — private, under Austin Wood's *personal*
GitHub account. It was never transferred to you.

Established from the mail archive:

- 2022-08-23, Austin to Christian, "here are the next steps": `git clone
  https://github.com/AustinWood/listenup-mobile.git`, `npm install`, `npm start`,
  `npm run ios`, then "open the project in Xcode by navigating to `listenup-mobile/ios`
  and opening `ListenUp.xcworkspace`."
- No handoff, transfer, or offboarding email exists after the engagement ended in
  July 2023. The App Store *account* was transferred to you in Aug 2022; the *repo*
  was not.

**Ruled out.** `mediajunkie/OptiListen` and `Design-in-Product/optilisten` are the
marketing website (static HTML original, React rewrite). `designinproduct/listenapp` —
imported 2022-07-09 to a third GitHub account registered as `optilisten@designinproduct.com`
— is misleadingly named: it contains the designinproduct.com book/UX site, not the app.
Nothing named optilisten is cloned under `~/Development` on the Mac Studio.

**Bundle ID:** `com.optilisten.ios`

## The stack — this is the expensive branch

**React Native.** The npm build chain plus an `ios/ListenUp.xcworkspace` is
unambiguous. The version is unknown until we see `package.json`, but a 2021–22 project
predates the New Architecture entirely.

That means the compliance path is not a deployment-target bump. It is a four-year jump
across React Native, its native modules, CocoaPods, Node, and the Hermes/JSC boundary,
ending at a build that satisfies Xcode 26 / iOS 26 SDK. In a project nobody has opened
since July 2023, with `yarn.lock`-era pins that resolve against registries that have
moved on. This is the case where "minimal compliance" stops being minimal.

**Recommendation: price the SwiftUI rewrite against the RN upgrade before choosing.**
Not as a product decision — as the cheaper route to the same compliance outcome. The
app is four screens (goal, live session, reflection, stats), the data model is trivial
and entirely local, and the one genuinely hard part is speech detection, which is
`SFSpeechRecognizer` / `AVAudioSession` — Apple frameworks that a React Native app was
reaching through a bridge anyway. A native rewrite plausibly ships faster than the
upgrade *and* leaves you with a codebase Fable can work on for Phase 2 instead of a
dependency tree. I have not verified this by reading the source; it is the hypothesis to
test in the first day of access.

## The architectural wall, inherited

Worth knowing before anyone estimates, because it shaped the product and it has not
gone away:

- 2023-03-31, Austin: background mode works ~30 seconds at a time. Two options
  demoed; switching to **CallKit** was "a much larger lift."
- 2023-04-07, Austin: recommends shipping "despite the 30-second limitation."
- 2023-05-17, Alexis: improved to **50 seconds** in background, resuming on foreground.
- 2023-05-18: Dan and Alexis discuss adding a popup *warning users* the background mode
  has a time limit — a UI apology for an architectural constraint.
- 2023-07-11, Austin: **"The app was rejected due to the background mode changes."**

So the shipped 1.1 measures a call for under a minute unless the app stays foreground —
in an app whose entire premise is tracking you through a meeting you are attending in
another app. That is the real reason the product underperformed, and no amount of
compliance work fixes it. A native rewrite with a properly declared `audio` background
mode and a live `AVAudioSession` is the standard way apps run indefinitely in the
background; whether that clears review for this use case needs verifying, not assuming.
It is also the single highest-leverage thing that could change in a Phase 2 rebuild.

**Note the rejection precedent.** Apple has already rejected this app once, specifically
over background modes. Any resubmission touching that area should expect scrutiny.

## What Apple requires at submission

1. **Xcode 26 / iOS 26 SDK.** Mandatory for all uploads since 2026-04-28. Rejected at
   upload, before review. → https://developer.apple.com/news/upcoming-requirements/
2. **Deployment target.** iOS 11 is unsupported. Xcode 26 targets iOS 15+; Xcode 27 makes
   anything lower a build error. *Recommend iOS 17*, verified against App Analytics.
3. **Privacy manifest** (`PrivacyInfo.xcprivacy`) for the app and every third-party SDK
   on the required-reason list. A React Native dependency tree makes this materially
   worse than it would be natively — each surviving native module needs its own.
   Everything is local to the device, so the declarations are honest and short, but they
   must exist. Common rejection cause.
4. **Age rating — social media questions.** Required *at submission* as of Sept 2026.
   A submission gate, not a removal deadline. Answers are "no" across the board.
   Ten minutes. → https://developer.apple.com/news/?id=tlur8uvi
5. **Encryption declaration** (`ITSAppUsesNonExemptEncryption` in Info.plist), or every
   upload stalls on a manual question.
6. **Screenshots** regenerated on a current simulator. The 2021 set is good — keep its
   structure: goal → live session → reflection → reward.
7. **Microphone and speech-recognition usage strings** must still be present and current.

## Blocking actions

### 1. Get the repo from Austin — today

You are on warm terms: you had a call 2026-05-12 and emailed him 2026-06-20. He is
Founder/CEO of Fractal Labs and CTO at Elanah.ai. This is a small, friendly ask.

**Slack him:**

> Hey Austin — blast from the past. Apple's threatening to pull OptiListen from the
> store unless I ship an update by Nov 24. Turns out the app repo is still
> `AustinWood/listenup-mobile` on your personal account — never got transferred when we
> wrapped. Could you either transfer it to me or add me as a collaborator? My GitHub is
> @mediajunkie. Also, if you happen to remember the React Native version and whether
> there were any signing/build gotchas, that'd save me a couple hours. No rush beyond
> the deadline, and thanks — happy to buy you lunch for it.

**Ask for, specifically:** repo transfer or collaborator access; any `.env` or build
config not in the repo; and whether an `ios/` build ever depended on anything on his
machine. If the repo is gone rather than private, say so early — that changes everything.

### 2. Verify the Apple Developer Program membership — today, independently

**https://developer.apple.com/account**

This is not optional diligence. In July 2023 an unsigned Program License Agreement
blocked publishing and Fractal had to chase you for it twice; you also had to update the
credit card. Three years later, a lapsed membership or unsigned agreement is a real
possibility, and it blocks everything downstream with its own turnaround. Check before
committing to a schedule.

Also check, in the same session: signing certificates and provisioning profiles (a 2023
profile is expired), and that the `com.optilisten.ios` identifier is still registered.

### 3. Pull App Analytics

**https://appstoreconnect.apple.com** → App Analytics → installs, active devices, iOS
version distribution, and retention for 2021–2023.

Decides the deployment target for Phase 1 and is the main input to Phase 2. The
retention curve in particular is the honest evidence on whether anyone came back — and
it should be read *knowing* the 50-second background limit was suppressing it.

## Phase 1 — Comply

**Goal:** approved 1.2 in the store, buying back the listing and the 2021 provenance.

**Target: 2026-10-15**, leaving 40 days of slack. That posture was right when this
looked like a native bump; with React Native and a prior background-mode rejection it is
the minimum responsible buffer.

**Day one of access:** read `package.json`, `Podfile.lock`, and the native module list.
Attempt a build on the existing toolchain to see how far it gets. That single afternoon
decides upgrade-vs-rewrite, and everything downstream is a guess until it happens.

Do not start Phase 2 product changes until 1.2 is approved.

## Division of labor

| Who | Owns |
|---|---|
| **Christian** | Austin ask, Developer Program status, App Analytics — none of these can be delegated |
| **Pard** (Mac Studio) | Xcode 26, signing, certs and profiles, archive, upload, App Store Connect |
| **Fable** | Refactor / rewrite once the upgrade-vs-rewrite call is made |
| **This session** | Compliance requirements, scope call, Phase 2 evaluation, the Dan proposal |

## Phase 2 — Evaluate

OptiListen's original measurement — how much of a call you spent talking — has been
absorbed by the ubiquitous underpinnings. Zoom, Teams, Granola, Gong and Fathom all
report talk ratio for free, at higher fidelity, without the user starting anything.

That kills the measurement proposition. It does not obviously kill the practice
proposition, and the distinction is the whole decision.

What the 1.1 screens actually do: **set a goal before the meeting** → **see the gap
while you can still act on it** → **rate how present you were afterward** → **goal vs.
actual over time**. Every meeting tool measures. None asks you to commit beforehand or
to assess yourself after. The incumbents produce analytics about a meeting; OptiListen
produced a rehearsal loop for a person. That gap is the only defensible position, and it
maps onto the attention thread running through the rest of the portfolio.

**The strongest version of "reposition":** stop measuring. Read the talk ratio the
incumbents already produce, and be the practice layer on top of it. That is cheaper to
build than the original app, sits above the commodity layer instead of competing with
it, and — critically — **routes around the background-mode wall entirely**, because you
are no longer trying to listen through a meeting you are not in front of. The constraint
that broke the 2021 product is the constraint the 2026 product would not have.

**What the evaluation must answer honestly:**

1. Will people open an app for listening practice, repeatedly, unprompted? Read the
   2021–23 retention data first — but read it knowing the background bug was capping it.
2. Who pays, and for what? Coaches and facilitators as a client-facing tool; sales and CS
   managers as team practice; therapists, mediators, teachers. None is the consumer who
   downloaded it free in 2021.
3. Does the measurement layer's ubiquity become an *asset* if you consume it rather than
   compete with it? Requires knowing what Granola, Zoom, and Gong actually expose via API.
4. What does sunset cost? Near zero, and it is not failure. A 2021 app that identified a
   real behavioral problem before the tooling caught up is a genuine precursor, and there
   is a good piece to be written about it either way.

**Deliverable:** a proposal to Dan Brodnitz after 1.2 ships, presenting reposition vs.
sunset with retention and analytics attached. Not before — the compliance clock should
not be spent on strategy.

## Open questions

- Does Austin still have the repo, and will he transfer it? *Everything depends on this.*
- React Native version and native module list — decides upgrade vs. rewrite.
- Is the Apple Developer Program membership current? *Hard prerequisite.*
- Does the Mac Studio have Xcode 26 installed?
- Installs, iOS-version distribution, retention.
- Is Dan a co-decider on reposition-vs-sunset, or a courtesy consult? Changes when he
  gets looped in, not just what he sees.

## Fallback if the repo is unrecoverable

Not the likely case, but worth naming so it isn't a surprise: the app is four screens,
the behavior is fully documented in the App Store screenshots, the marketing site copy,
and three years of this mail thread. A from-scratch SwiftUI build against the existing
bundle ID and App Store listing is a real path, and on a React Native project this old
it may be the faster path *even if Austin hands over the keys tomorrow*. Losing the
source is a setback, not an ending.
