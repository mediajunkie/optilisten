# optilisten.com — site audit and plan

**Date:** 2026-09-27 · **Author:** Cairn · **Repo:** `Design-in-Product/optilisten` (React SPA, GitHub Pages) · **Status:** Tier 1 and 2 shipped and deployed live; Tier 2 item 3 (privacy) and Tier 3 held

Prompted by the same thread as `docs/store-content-2.0.md`: the app's live copy (App Store and site
both) says the opposite of how OptiListen actually works. That listing draft already covers the App
Store side. This is the site's turn.

## What's already fixed

- **2026-09-24, xian:** `/privacy` returned a real file instead of 404 (the SPA-routing gap noted
  in rev 32/33 of the rollup). Content of the page not touched.
- **2026-09-27, this pass, `5087264`:** the homepage hero paragraph and the "Do I need to wear
  headphones?" FAQ answer both said, plainly, that headphones were required and that's how the app
  tells you apart from the other person. That's backwards for 2.0 (and see the open question below
  about 1.x). Patched both to the correct mechanism — phone listens to the room, proximity is the
  discriminator, headphones make it unreliable and the app says so rather than guessing.
- **2026-09-27, this pass, `c8b80fd`:** Tier 2 items 1–2 below (tagline and hero blurb) — same pass,
  same reasoning, no need for a separate go-ahead once the plan was agreed.
- **Deployed live** the same pass: `npm run deploy` from a fresh `npm install`, published to the
  `gh-pages` branch at 2026-09-27T02:25:12Z. Verified the new copy is actually in the shipped bundle
  (`build/static/js/main.b4a82ac3.js`) rather than just committed to `main` — pushing to `main` alone
  does not update the live site; this repo has no CI/deploy workflow, `npm run deploy` is a manual
  step. Worth knowing for next time: a future patch to this repo is not live until someone runs it.

## Open question this patch rests on — RESOLVED 2026-09-27

**xian confirmed directly: 1.x was in fact designed to be used with headphones.** So the patched
copy above is, briefly, wrong about the app the site's "Try the Free App" button actually delivers
today — it describes 2.0's mechanism, not 1.1's. **Left as-is, on xian's call:** there are no active
or new users of 1.x right now, so a short window of copy/app mismatch costs nothing, and the copy
becomes true the moment 2.0 ships. See D-022 in `docs/decisions.md`. No further change needed here.

## Findings from reading the rest of the site

| Area | File | Finding |
|---|---|---|
| Homepage tagline | `Dashboard.tsx` | "Unlock the listener within" — same 2021 self-help line already rejected as the App Store subtitle (store-content-2.0.md: "a 2021 self-help line for a measurement app"). Appears twice more (`AboutApp.tsx` hero, both breakpoints). |
| About/Who We Are | `AboutApp.tsx` | Team credit and origin story are fine and don't need to change. The hero blurb repeats the "track how much time you're speaking" framing — measurement-first, not the 2.0 practice-loop framing the App Store rewrite leads with. |
| FAQ — data collection | `AboutApp.tsx` | "It doesn't — no login, no data. All data is kept on your phone." Still accurate for 2.0. No change needed. |
| FAQ — general | `AboutApp.tsx` | Tone (";-)", "Be hear now, good people!") is very 1.x-brand-voice. Not wrong, just worth a decision on whether it survives the 2.0 relaunch or gets tightened along with everything else. |
| Privacy policy | `Privacy.tsx` | Still dated **4 July 2022 / effective November 1, 2022**, and per the rollup's rev-32 finding, never mentions the microphone at all. This is the one page here with actual submission-day and legal exposure — App Store review reads this, and it currently doesn't describe what the app you're submitting actually measures. |
| Feedback form | `Feedback.tsx` | Generic, harmless copy; posts to a Google Form. Nothing wrong, nothing 2.0-specific either. |
| Screenshots/art | `Dashboard.tsx`, `AboutApp.tsx` | Uses illustration assets (`phones.png`, `Fireworks.png`), not actual app screenshots — so unlike the App Store listing, there's no stale-screenshot problem here to fix in lockstep with the fixture work. |
| Nav/footer | `Header.tsx`, `Bottom.tsx` | Structural only — App Store link, social links. No copy issues found. |

## Proposed scope, in three tiers

**Tier 1 — done this pass.** The two backwards mechanism claims (hero, FAQ). Low risk, pure text,
shipped as `5087264`.

**Tier 2 — copy-only, safe to do now, no design/asset work.**
1. Replace "Unlock the listener within" everywhere it appears (3 spots) with the same subtitle
   decided for the App Store, `A rehearsal for listening`, so the two surfaces agree.
2. Rewrite the hero/About blurbs to lead with the practice loop rather than measurement, echoing
   the App Store description's framing rather than duplicating its exact paragraphs.
3. **Privacy policy content rewrite** — update the date, and add what the App Store review notes
   already commit to saying: on-device loudness classification, no recording, no transcription, no
   network calls. I'd flag this one for your read before it goes live rather than pushing it
   unilaterally; it's the one page here that's closer to a legal document than marketing copy.

**Tier 3 — hold for the 2.0 relaunch itself**, same reasoning as the App Store screenshots (don't
shoot twice): FAQ tone pass, any visual refresh toward the moss/amber theme, and revisiting whether
this site's whole structure (Dashboard/About/FAQ/Feedback) still matches what 2.0 is. Doing this
before 2.0 has a submission date risks redoing it if anything about the app changes between now and
then.

## Recommendation

Tier 2 items 1–2: done, pushed, deployed (`c8b80fd`, live). Item 3 (privacy) I'll draft next but hold
for your sign-off before pushing — it's the one page here closer to a legal document than marketing
copy, and unlike the copy above it isn't just restating a decision already made elsewhere. Tier 3
I'd leave alone until there's a submission date, same logic as the screenshot sequencing elsewhere in
this project.

— Cairn, 2026-09-27
