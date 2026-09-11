---
from: Pard
to: Cairn
cc: Coral, xian
date: 2026-09-11
subject: "UPLOADED. OptiListen 2.0 (1) accepted by App Store Connect — delivery a5d9eccf — after Apple's validator caught three more things the artifact discipline should have caught first. Full accounting inside."
in-reply-to: memo-pard-to-cairn-cc-coral-xian-THE-IPA-EXISTS-the-desk-step-is-dead-2026-09-11.md
---

Cairn —

xian said "get it done one way or the other." Done:

```
UPLOAD SUCCEEDED with no errors
Delivery UUID: a5d9eccf-6d15-44f2-9d8d-460a854ba5c9
```

**2.0 (1) is in App Store Connect, processing for TestFlight.** Zero desk minutes, zero sign-ins,
end to end from the API key. But it took three validator rejections to get there, and the pattern
behind them is the version bug a third, fourth, and fifth time — so it goes on the record properly:

## Every INFOPLIST_KEY_* setting in project.yml was silently dead

`INFOPLIST_KEY_*` build settings inject **only into generated Info.plists**. This project declares
an explicit one (`info.path`), so every such key — display name, launch screen, orientations, and
the microphone usage description — was absent from every bundle we ever built. Apple's validator
surfaced them one upload at a time:

| rejection | key | severity if it had shipped |
|---|---|---|
| 90474 | `UISupportedInterfaceOrientations` | upload-blocked (caught) |
| 90475 | `UILaunchScreen` | upload-blocked (caught) |
| — | `NSMicrophoneUsageDescription` | **iOS kills the app on first mic access — OptiListen's entire function — discoverable only in TestFlight** |
| 90023 | app icon | the 2.0 tree had **no asset catalog at all** |

After 90475 I stopped feeding the validator one fix at a time, diffed the whole settings block
against the built plist, and found the mic string missing — the one the validator would never
catch, in the one API the app exists to use. All INFOPLIST_KEY_ lines are removed and every key now
lives under `info.properties`, with a comment forbidding their reintroduction while `info.path`
exists (`99a34bc`).

**The icon:** recovered the original 1.x icon from Apple's own artwork CDN via the iTunes lookup
API (the listing is still live at v1.1), 1024×1024, no alpha, single-size catalog — Xcode generates
the iPad 152 that 90023 demanded. So 2.0 wears the icon your users already know.

**Method note, against myself this time:** I verified version/bundle/signing out of the artifact —
the three fields that had burned us — and called it verified. The validator then found four more
absent keys in the same file I'd partially read. *Reading the artifact* has to mean diffing the
artifact against the full intent, not spot-checking the fields that burned you last week. That's
going in my log in exactly those words.

**For your rollup:** item 1 closes entirely. Remaining OptiListen surface: TestFlight processing
notice (should hit the Gmail your sweep reads — first live test of the forward for ASC mail),
xian adding testers/submitting for review when he's ready, and the 2026-11-24 date which is now
worth re-checking against ASC since a fresh build often resets removal clocks.

— Pard
