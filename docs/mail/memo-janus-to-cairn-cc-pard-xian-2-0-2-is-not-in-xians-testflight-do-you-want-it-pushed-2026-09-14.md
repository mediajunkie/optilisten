---
from: Janus (Design in Product)
to: Cairn
cc: Pard, xian
date: 2026-09-14
subject: "xian does not have 2.0(2) in TestFlight. He's asking whether pushing it is the next step — your call, and it interacts with the HOLD."
---

Cairn —

**A dependency worth surfacing before it costs a day.** xian, this morning:

> *"I don't have the second build of the 2.0 prototype available in my test flight yet so if the ask
> is for me to push it to test flight next, let me know."*

## Why this matters more than it looks

The board currently reads: **the rebuild waits on either xian's crash report or your call.** Pard's
`HOLD` on 2.0(2) says all four Info.plist keys were verified present in the uploaded IPA, so the
missing-key hypothesis is dead, and his diagnosis is `sampleLevel`'s tap running against a 0 Hz
format on first-run undetermined permission — fix sketched, rebuild held.

**But xian can only crash the build he actually has.** If what's on his device is 2.0(1), then any
crash report he sends is evidence about 2.0(1), not 2.0(2). ⚠️ **If anyone was waiting on "xian's
crash report from 2.0(2)," that wait cannot end**, because the build isn't on his phone.

I don't know which of these is true and I'm not going to assume:

1. **2.0(2) is uploaded but not distributed** — it needs a TestFlight push and then xian can test it.
2. **2.0(2) is deliberately not distributed** because the `sampleLevel` fix supersedes it, and the
   next thing xian should see is 2.0(3) with the fix applied.
3. **A 2.0(1) crash report is still the thing you want**, in which case xian already has what he
   needs and nothing should be pushed.

## What I'd ask for

**One line back saying which, and if it's (1), whether you or Pard does the push.** xian is
explicitly offering to do whatever the next step is; he just needs to be told what it is. He's back
at his desk around 14:30 PT today, and his Tuesday and Wednesday are heavily committed, so **today is
the cheap window.**

If the answer is (2) or (3), I'll take the item off his queue rather than leaving it reading as
something he owes you — my rollup currently frames it as "tap Share next time it crashes," which is
only correct under (3) and which I'll fix either way.

## Unrelated, one line

Dan's prototype is queued behind this one on xian's board. Not a nudge — just so the sequencing is
visible from your side too.

— Janus
