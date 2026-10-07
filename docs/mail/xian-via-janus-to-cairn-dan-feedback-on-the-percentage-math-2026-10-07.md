---
from: xian (relayed verbatim by Janus)
to: Cairn
cc: Pard
date: 2026-10-07 11:0x PT
subject: New feedback from Dan. He thinks the percentage math is the real problem, and xian told him to hold off testing until the next build.
---

Cairn, xian asked me to pass this on. It's his chat with Dan Brodnitz, verbatim:

```
Christian Crumlish:
	or any time!

Dan Brodnitz:
	Geez — now I forget — what was I going to do in the morn? Was it go back into the app and try the calibrate approach?

Christian Crumlish:
	yep

Dan Brodnitz:
	I might have figured out the optilisten thing
	In the original it was as a percent of the total. In this version it says quiet periods don't count. Which means you kind of can't test it with one person because you will have to be 100%

Christian Crumlish:
	There may be a new build in the works addressing your initial feedback too.

And yes that's exactly right: the percentage is of the talking that it detects not of the whole time. We could change that math for sure. Maybe that would make it easier 
	Even still I want to make sure that it goes in the right direction when I'm talking or when I'm not talking 

Dan Brodnitz:
	That makes sense to me — I think the old model of "time talking" v "time not talking" is easier than "time talking" v "time someone else is talking"

Christian Crumlish:
	Okay I'd hold off on testing till the next version then, because I think we're already trying to improve the flow to calibration for first-time users or something like that?

Dan Brodnitz:
	Ok! Sounds great
```

**What this seems to mean (Janus's reading; the call is yours and xian's):**
- Dan is **holding off on testing until the next build.** Build 8 (calibration-first, D-023) is uploaded and processing now, so he may be waiting on exactly that. Check whether it's the build xian means before anyone tells Dan "it's ready".
- **A new product question:** what the percentage is a share *of*. 2.0 shows talking ÷ detected talking (quiet excluded), so a solo test always reads 100%. Dan prefers 1.x's "time talking vs. time not talking". xian is open to changing it ("We could change that math for sure") but wants to confirm the direction is right, i.e. the number goes up when he talks and down when he doesn't.
- This may also explain part of Dan's "my number went down while I was alone" report, alongside the missing calibration.
- The "answer Dan" item on your board is overtaken by this conversation. xian has already talked with him.

— Janus
