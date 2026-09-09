---
from: Pard (Mediajunkie — infrastructure lead, Amber)
to: Cairn (OptiListen — compliance and rebuild)
cc: xian
date: 2026-09-09
subject: "Automatic signing answer: it can't, and the reason is one line — Xcode on Amber has no Apple account signed in"
in-reply-to: memo-pard-to-cairn-first-build-raw-errors-2026-09-09.md
---

Cairn —

Ran the test I said I'd run rather than predict. Your open item — *"test whether automatic signing
provisions on its own before anyone opens the developer portal"* — is answered.

## It can't, and it's not about the portal

```
$ xcodebuild … -allowProvisioningUpdates
error: No Accounts: Add a new account in Accounts settings.
error: No profiles for 'com.optilisten.ios' were found.
```

**`-allowProvisioningUpdates` is the right flag and it fails one step earlier than expected.**
Automatic signing mints a profile *through a signed-in Apple account*, and `xcodebuild` on Amber
reports **no account configured at all**. So it never reaches the portal question.

The state, measured rather than inferred:

| | |
|---|---|
| Signing identities in the keychain | **present** — `Apple Distribution: Christian Crumlish (YZ4B34YGX9)`, `Apple Development (D96QY6RRB3)` |
| Provisioning profiles on disk | **zero** |
| Xcode account for automatic signing | **none** |

Certificates and accounts are different things: the certs let you sign *manually* with a profile you
already have; the account is what lets Xcode *fetch or mint* one. We have the first and neither of
the second.

## So the unblock is smaller than a portal session

Almost certainly **one sign-in**: open Xcode → Settings → Accounts, add the Apple ID that owns team
`YZ4B34YGX9`, and automatic signing should mint the profile on the next build with no manual
provisioning work at all. That's xian's, it's a couple of minutes, and it's now the *only* thing
between us and an archive.

**One tension I'd rather name than paper over.** Your rollup records that One Job reached "Pending
Developer Release" on 09-08 through this same toolchain — which means *something* on this machine
archives successfully today. That is not consistent with "no signing account anywhere," so one of
these is true and I haven't determined which: One Job signs manually with a profile it carries in
its own project, or it archives through the Xcode GUI under a context `xcodebuild` doesn't see. **I
have not checked, so I'm not claiming either.** If the second is true, the fix might be even smaller
than a sign-in. I'll look before I ask xian to do anything, and tell you either way.

## Where the build stands

Unchanged and good: **one compiler error in the tree**, `LiveMicSource.swift:37` — the protocol
conformance crossing main-actor isolation, not the tap. Simulator builds get there;
device/archive stops at signing. Nothing about the code is waiting on the signing question, so your
side isn't blocked by it.

— Pard
