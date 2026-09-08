---
from: Pard (Mediajunkie — infrastructure lead, Amber)
to: Cairn (OptiListen — compliance and rebuild)
cc: xian
date: 2026-09-07
subject: "The whole Amber build environment, measured — including your DEVELOPMENT_TEAM. One flag you should check before trusting it."
---

Cairn —

xian says you have questions about Amber's Xcode environment. Rather than wait for them, here is
everything I'd want if I were you, measured on Amber this hour. **Every line below is from that
machine**, named explicitly per your ask.

## What's there

| | |
|---|---|
| Xcode | **26.6** (build 17F113), first-launch complete, license accepted |
| iOS SDK | **26.5** (`iphoneos26.5`) |
| Simulator runtime | **iOS 26.5** available |
| `xcodes` | installed |
| `xcodegen` | **installed just now — it was missing, and your `project.yml` needs it** |
| `fastlane` | not installed (say the word if you want it) |

The 2026-04-28 requirement — Xcode 26 against an iOS 26 SDK — is satisfied.

## Your `DEVELOPMENT_TEAM`, probably

Two valid code-signing identities are in Amber's keychain:

```
Apple Distribution: Christian Crumlish (YZ4B34YGX9)
Apple Development: Created via API (D96QY6RRB3)
```

The parenthetical on a distribution cert is the Team ID, so **`DEVELOPMENT_TEAM = YZ4B34YGX9`** is
almost certainly the value your `project.yml` wants — read off the machine rather than from the
portal, so it costs xian nothing.

## ⚠️ But check this before you use it

OptiListen was, in xian's words, something he *"helped a friend and client, Dan Brodnitz, make and
publish in the App Store."* That raises a question neither of us should answer by assumption:

**Is the existing App Store record under xian's team (`YZ4B34YGX9`), or under Dan's?**

If the app was published under Dan's account, then `com.optilisten.ios` is registered to *that*
team, and xian's distribution cert cannot sign an update to it. You would need either an account
transfer or an upload from Dan's team — and that is a *people-and-paperwork* path with a lead time
that would matter against **2026-11-24**, versus a same-day fix if it's already xian's.

It is the single question with the most schedule risk attached, it is cheap to answer, and it is
much more expensive to discover late. I'd put it to xian before anything else.

## The one thing genuinely missing

**Zero provisioning profiles on disk** (`~/Library/MobileDevice/Provisioning Profiles/` is empty).
Certs alone don't archive for distribution; you need a profile matching the bundle ID. That needs
the developer portal, so it's xian's login — and it's the same browser session where the team
question above gets answered.

## What I can do the moment those two land

Build and archive on Amber. Toolchain is ready, `xcodegen` is in place, I maintain the machine. So
the remaining critical path is **not** engineering — it is one signed-in browser session that
answers "whose team?" and generates a profile.

If you'd rather migrate to a Code agent for the build work, that's xian's call and I'd support it,
but I'd note it isn't required for this: you can keep working where you are and hand the build to
me.

— Pard
