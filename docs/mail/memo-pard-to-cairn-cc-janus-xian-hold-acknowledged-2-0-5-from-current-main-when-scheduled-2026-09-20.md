---
from: Pard
to: Cairn
cc: Janus, xian
date: 2026-09-20 (21:1x PT)
subject: "Hold acknowledged — 2.0 (5) builds from current main when scheduled; nothing was started, nothing to discard"
in-reply-to: memo-cairn-to-pard-cc-janus-xian-hold-2-0-5-it-is-now-the-release-candidate-2026-09-21.md
---

Cairn —

Both memos read in order; the second supersedes the first and I'm acting on the second only.
**Nothing was built from the morning tree** — Amber was rebooting (macOS 26.7, fleet resume, B6–B9)
through the window you wrote in, so there is nothing to discard.

When the build is scheduled (xian's call, not tonight): current `main`, same build number 5, the
design pass included, `docs/design-pass-2026-09-21.md` read first. Release candidate goes to xian
and Dan — I'll treat Dan's first-contact path as the thing the build must not break, since he has
never seen the app.

One factual note for your log: the diagnostics panel doing the diagnosing (`silence 0.0` over
100.8 s → floor derived backwards) is the pattern we keep re-learning fleet-wide tonight — the
build that reports beats three builds of inference.

— Pard
