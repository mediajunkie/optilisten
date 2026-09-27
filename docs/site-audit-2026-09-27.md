# optilisten.com — site audit and plan

**Date:** 2026-09-27 · **Author:** Cairn · **Repo:** `Design-in-Product/optilisten` (React SPA, GitHub Pages) · **Status:** Tier 1 and 2 (all three items) shipped and deployed live; Tier 3 prepped and held for a 2.0 submission date

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
- **2026-09-27, xian approved Tier 2 in full, `687b760`:** item 3 — a "How the Microphone Is Used"
  section (on-device loudness classification, nothing recorded/transcribed/transmitted, no network
  code — the same language committed to in the App Store review notes) plus updating both stale
  dates (Privacy's 4 July 2022, Terms' November 2022) to today. Legal boilerplate below it (GDPR/CCPA
  sections) untouched — this was an addition, not a rewrite.
- **Deployed live**, both passes: `npm run deploy` from the checked-out build, published to the
  `gh-pages` branch — first pass at 2026-09-27T02:25:12Z, second at 2026-09-27T13:27:17Z. Verified
  the new copy is actually in the shipped bundle each time (`grep` against `build/static/js/*.js`)
  rather than just committed to `main` — pushing to `main` alone does not update the live site; this
  repo has no CI/deploy workflow, `npm run deploy` is a manual step. Worth knowing for next time: a
  future patch to this repo is not live until someone runs it.

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

**Tier 2 — copy-only, done.**
1. Replace "Unlock the listener within" everywhere it appears (3 spots) with the same subtitle
   decided for the App Store, `A rehearsal for listening`, so the two surfaces agree. — `c8b80fd`
2. Rewrite the hero/About blurbs to lead with the practice loop rather than measurement, echoing
   the App Store description's framing rather than duplicating its exact paragraphs. — `c8b80fd`
3. Privacy policy content addition — date updated, "How the Microphone Is Used" section added,
   legal boilerplate below it untouched. — `687b760`, xian's sign-off given 2026-09-27.

**Tier 3 — held for a 2.0 submission date, prepped below so it's a checklist, not a rediscovery.**

## Tier 3 — ready-to-execute checklist

Same reasoning as the App Store screenshots (don't shoot twice): none of this starts until 2.0 has a
submission date, so nothing here gets redone if the app changes between now and then. Concrete
enough that whoever picks it up — me, Pard, or Fable — doesn't have to re-derive it.

**1. FAQ tone pass.** `AboutApp.tsx` FAQ section. Specific lines to decide on, not just "tone":
   - `";-)"` and `"Be hear now, good people!"` — 1.x brand voice. Keep (it's a personality, not an
     error) or tighten to match the calmer 2.0 voice used in `store-content-2.0.md`? xian's call —
     this one is taste, not correctness, unlike everything fixed in Tiers 1–2.
   - Re-check every FAQ answer against 2.0's actual behavior once that build is final, the same way
     the headphones answer was wrong for 1.x's live copy (D-022) — don't let this be the next stale
     claim.

**2. Visual refresh toward the moss/amber theme.** Exact tokens, from `Theme.swift` (the app's own
   canonical values, so the site can match them rather than eyeball them):
   - **moss** (within-ceiling) — light `#3D6B54`, dark `#80B594`
   - **amber** (over-ceiling) — light `#B86B29`, dark `#E8A65E`
   - Site currently themes on Tailwind tokens in `tailwind.config.js` (`darkBlue #134466`,
     `lightBlue #3CA4A4`, `teal #34A0A4`, `midNight #0B1823`) plus one MUI override in `App.tsx`
     (`palette.info.main: #34A0A4`) — all blue/teal, nothing shared with the app's palette today.
     Swapping these for moss/amber tokens is the concrete unit of work; illustration assets
     (`phones.png`, `Fireworks.png` in `AboutApp.tsx`/`Dashboard.tsx`) would need a look once the
     palette moves, since they're likely painted to the current blue.
   - Consistent with `Theme.swift`'s own rule ("the app's WHOLE palette... an untokenised colour
     that happens to resemble a token is how two screens end up disagreeing") — same logic applies
     across app and site, not just within the app.

**3. Site structure revisit.** Once 2.0's actual screens exist to show: swap the illustration-only
   Dashboard/About hero art for real app screenshots (the site has no stale-screenshot problem today
   only because it never had real ones — worth having them once they exist), and re-read whether
   Dashboard/About/FAQ/Feedback as four separate pages still matches a single-loop 2.0 story, or
   whether the practice-loop framing wants a simpler structure.

**Trigger to start:** a 2.0 submission date. Until then this section is the plan, not a task.

## Recommendation

Tier 2 (all three items): done, pushed, deployed, live. Tier 3: prepped above, deliberately not
started — same screenshot-sequencing logic as the rest of this project.

— Cairn, 2026-09-27
