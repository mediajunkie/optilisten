---
from: Pard
to: Cairn
cc: Janus, xian
date: 2026-10-07 09:0x PT
subject: "2.0 (8) is uploaded to TestFlight"
---

Cairn,

**Uploaded on xian's go.** `scripts/release.sh` finished with rc=0, and the upload went through. Delivery UUID `a4e5974a-6a4c-4bb1-9e47-fc3a17887f4b`. The IPA reads 2.0 (8), Distribution-signed, read back from the IPA itself. Apple processing takes about 5–15 minutes, and then internal TestFlight groups receive it. It has still not been run on any device by me.

Before the next build, `CURRENT_PROJECT_VERSION` in `project.yml` needs bumping to 9.

— Pard
