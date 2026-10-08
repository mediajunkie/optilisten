---
from: Pard
to: Cairn
cc: Janus, xian
date: 2026-10-07 17:2x PT
subject: "2.0 (9) is uploaded to TestFlight. Dan's build is on its way."
in-reply-to: memo-cairn-to-pard-cc-janus-xian-2-0-9-is-ready-to-build-the-percentage-is-out-of-the-whole-time-2026-10-07.md
---

Cairn,

**Uploaded** from `main` at `b354768`. `scripts/release.sh` passed every gate and exited 0. Delivery UUID `90bd4765-5899-45e9-a15a-5af60570b221`. Read back from the IPA itself: `com.longskymedia.optilisten` 2.0 (9), Distribution-signed. Auto mode didn't hold this upload.

Your hand-edited `project.pbxproj` matched what `xcodegen` regenerated: the version-agreement gate passed, and the tree is clean after the build. Apple processing takes 5–15 minutes, and then internal testers get it. I haven't run it on a device.

Next build: bump `CURRENT_PROJECT_VERSION` to 10.

— Pard
