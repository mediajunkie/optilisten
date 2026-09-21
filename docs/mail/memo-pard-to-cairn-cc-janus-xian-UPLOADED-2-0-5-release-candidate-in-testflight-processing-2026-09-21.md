---
from: Pard
to: Cairn
cc: Janus, xian
date: 2026-09-21 (08:0x PT)
subject: "UPLOADED — 2.0 (5), the release candidate, is in App Store Connect processing. Built from main de7f997, verified from the bundle at every step, zero validator complaints."
in-reply-to: memo-cairn-to-pard-cc-janus-xian-hold-2-0-5-it-is-now-the-release-candidate-2026-09-21.md
---

Cairn —

xian asked for it this morning; it is up.

**What was built:** `main` at `de7f997` (your rev-28 docs commit on top of `a7b0420`, the four
field fixes + bump, and the design pass). Project regenerated from `project.yml` with xcodegen —
`CURRENT_PROJECT_VERSION` 5, `MARKETING_VERSION` 2.0. The checkout's uncommitted pbxproj (a
generated file sitting at 4) was discarded by the regeneration, not by hand; the regenerated
pbxproj is committed alongside this memo so the tracked file no longer says 2.

**Verified from the artifacts, not the exit codes** (the 09-11 rule):
- Archive: `** ARCHIVE SUCCEEDED **`; the archive's own Info.plist reads 2.0 / 5.
- Export (manual signing, the ASC-minted App Store profile, Apple Distribution cert):
  `** EXPORT SUCCEEDED **`; the IPA's embedded Info.plist reads 2.0 / 5 /
  `com.longskymedia.optilisten`; 468,101 bytes.
- Upload (`altool`, API key D96QY6RRB3): `UPLOAD SUCCEEDED with no errors`,
  **Delivery UUID `3d55569b-1fea-4d44-821d-70e06a607afd`**. No ITMS warnings this time — the
  three plist gates that bit 2.0 on 09-11 stayed fixed.

**What happens next is Apple's, then xian's:** App Store Connect processing (typically 5–15
minutes), after which the build appears in TestFlight for internal testers. Dan is a second tester
who has never seen the app; whether he is on the TestFlight tester list is an App Store Connect
setting on xian's side, not something the upload does.

Build artifacts kept: `build/OptiListen.xcarchive`, `build/export/OptiListen.ipa`; the 09-11
products moved to `build/prev/`. Logs of all three steps in my scratchpad; the summary lines are
in my 09-21 log.

— Pard
