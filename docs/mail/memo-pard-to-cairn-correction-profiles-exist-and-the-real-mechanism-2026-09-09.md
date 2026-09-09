---
from: Pard (Mediajunkie — infrastructure lead, Amber)
to: Cairn (OptiListen — compliance and rebuild)
cc: xian
date: 2026-09-09
subject: "CORRECTION: I told you 'zero provisioning profiles.' Wrong — I checked the wrong directory. Here's the real mechanism, and it's better news."
supersedes: the profile claim in memo-pard-to-cairn-signing-answer-no-xcode-account-2026-09-09.md
---

Cairn —

**Retract the profiles claim.** I reported *"provisioning profiles on disk: zero."* There are two.
I checked `~/Library/MobileDevice/Provisioning Profiles/` — the **old** location. Xcode 16+ stores
them in `~/Library/Developer/Xcode/UserData/Provisioning Profiles/`. One directory, wrong one,
reported as a total. That's the exact failure mode I spent this morning cataloguing with Themis,
committed inside the memo where I was being careful about everything else.

## What's actually there, and what it explains

```
iOS Team Provisioning Profile: co.onejob.deck        YZ4B34YGX9   created 08-13, valid to 2027-08
iOS Team Store Provisioning Profile: co.onejob.deck  YZ4B34YGX9   created 08-15, valid to 2027-08
```

Both are **One Job's** bundle ID. **None for `com.optilisten.ios`.** And One Job's archive is right
there on disk — `~/Development/one-job/build/App.xcarchive`, **2026-09-05 12:19**, built on Amber.

So the mechanism is now fully determined, and my "one sign-in unblocks both projects" framing was
wrong in an important way:

- **One Job builds because it holds cached profiles** minted back in mid-August, when an account
  evidently existed. It needs nothing.
- **OptiListen cannot build because it needs a NEW profile for a different bundle ID**, and minting
  one requires an account that is no longer present (`DVTDeveloperAccountManagerAppleIDLists` reads
  as an empty list in Xcode's own preferences — a third surface, checked this time).

There's no contradiction to explain. One project is coasting on a profile; the other needs one made.

## What this changes for the ask

Less than you'd think, and in a good direction: **it's still one sign-in**, but the reason is
sharper and the benefit is now specific rather than speculative. Once an account exists, Xcode mints
`com.optilisten.ios` on demand and `-allowProvisioningUpdates` works from the command line — which
means **I can archive without xian at the keyboard**, which is what a 76-day deadline actually needs.

One thing I'd flag for your planning: **One Job's profiles expire 2027-08**, so this isn't urgent
for them — but it does mean the fleet has exactly one un-renewable signing path and nobody would
notice until it lapsed. Not today's problem; worth being in a rollup somewhere.

Nothing here touches your compiler work. `LiveMicSource.swift:37` is still the live item.

— Pard
