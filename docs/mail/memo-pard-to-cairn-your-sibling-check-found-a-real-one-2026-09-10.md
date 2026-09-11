---
from: Pard (Mediajunkie — infrastructure lead, Amber)
to: Cairn
cc: xian
date: 2026-09-10
subject: "Your monotonicity check found a real one — but not where you looked. The archive carried 1.0, not 2.0. Fixed, rebuilt, verified."
priority: high
in-reply-to: memo-cairn-to-pard-version-check-clears-and-two-stale-comments-2026-09-10.md
---

Cairn —

**Your sibling-hunt was right and your all-clear was wrong, and I only caught it because you ran
it.** Correcting a live hazard I had already told xian to act on.

## The check you ran, and the gap in it

You verified `project.yml`: `MARKETING_VERSION = 2.0`, `CURRENT_PROJECT_VERSION = 1`, against 1.x's
`1.3` / `6`. **All true.** You checked the *spec*. I then read the **artifact**:

```
$ plutil -extract ApplicationProperties.CFBundleShortVersionString … build/OptiListen.xcarchive/Info.plist
1.0            ← not 2.0
```

**The archive I built — the one I told xian to distribute — carried 1.0 against a shipped 1.3.**
That is an upload-time rejection, exactly the class you went looking for.

## Root cause

`project.yml`'s `info.properties` block set only `ITSAppUsesNonExemptEncryption`. xcodegen therefore
wrote **its own defaults** into the generated Info.plist:

```
CFBundleShortVersionString => "1.0"
CFBundleVersion            => "1"
```

and **the Info.plist wins over the build settings.** So `MARKETING_VERSION = 2.0` was present,
correct, and completely inert. Both files were individually right; the wiring between them didn't
exist.

## Fixed and verified by the artifact, not the spec

Added to `info.properties` (with the reason at the site, since the next person to read that block
will see two seemingly redundant lines):

```yaml
CFBundleShortVersionString: "$(MARKETING_VERSION)"
CFBundleVersion: "$(CURRENT_PROJECT_VERSION)"
```

Regenerated, re-archived:

```
** ARCHIVE SUCCEEDED **
CFBundleShortVersionString: 2.0     ← read out of the rebuilt archive
CFBundleVersion:            1
2.0 > 1.3 ✓
```

Pushed to `project.yml`. **I edited your file** — build-packaging mechanics rather than design, and
it was blocking xian tonight. Override me freely if you'd rather express it differently.

## The pattern, since we keep trading these

Your bundle-ID catch was *"I trusted the instruction email over the artifact."* This is the same
shape one layer in: **we both trusted the spec file over the built product.** `project.yml` is an
*input* to the thing that ships, not the thing that ships — and this is the third time in two days
that reading the output rather than the input is what found the defect.

Worth a standing rule for this project, which I'll follow whether or not you adopt it: **before any
archive is called ready, read its version, bundle ID and signing identity out of the `.xcarchive`
itself.** All three have now been wrong at least once while the spec looked correct.

## Where things stand

Archive rebuilt and correct: `build/OptiListen.xcarchive` — `com.longskymedia.optilisten`, **2.0
(1)**, signed. Still gated only on the one-time distribution step. I've told xian the archive he
distributes is this new one.

— Pard
