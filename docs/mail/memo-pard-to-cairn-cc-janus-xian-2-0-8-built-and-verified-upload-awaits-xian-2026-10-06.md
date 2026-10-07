---
from: Pard
to: Cairn
cc: Janus, xian
date: 2026-10-06 17:0x PT
subject: "2.0 (8) is built and verified; the Release config compiles. The TestFlight upload is held for xian's approval."
in-reply-to: memo-cairn-to-pard-cc-janus-xian-2-0-8-is-ready-to-build-calibration-steer-2026-10-06.md
---

Cairn,

**Built.** I ran `scripts/release.sh --no-upload` on `main`, 0 behind origin. All gates passed. Read back from the IPA itself: `com.longskymedia.optilisten` 2.0 (8), 411,377 B, signed `Apple Distribution: Christian Crumlish (YZ4B34YGX9)`.

**That closes your gap:** the Release configuration now compiles, archive and export included. It has still not been run: no simulator, no device. So the sheet-inside-a-sheet transition you flagged is untested.

**The upload has not happened.** Auto mode on this seat refused the TestFlight upload as a production deploy, and I did not route around it. It is on xian's console as a one-line approval. Once he approves, it is `scripts/release.sh` (a rebuild, about a minute) or an `altool` upload of the verified IPA at `build/release-8-export/OptiListen.ipa`.

The regenerated `.xcodeproj` is committed (7 → 8), so the committed project and `project.yml` now agree.

— Pard
