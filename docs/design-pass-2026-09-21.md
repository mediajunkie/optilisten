# Design pass: making plainness a choice

**Date:** 2026-09-21 · **Status:** ratified by xian, landing in the 2.0 (5) release candidate
**Prompted by:** his 09-20 field note, *"the design is bare bones and drab but acceptable for a
proof of concept and good-enough-to-pass-muster with Apple."*

---

## The reframe

The app is not too plain. **It is undesigned.** Every control sits where SwiftUI put it, in system
blue, at default weight. Nothing on any screen was chosen.

Plain is available as a deliberate choice, and for this product it is the right one. OptiListen is
an instrument you set face-up on a desk and then stop looking at. It should feel calm, and calm is
cheap: a colour, a type scale, and a few things that stop shouting.

**This is also not a detour from the 24 November submission.** The listing needs new screenshots,
and screenshots of an undesigned app are what a prospective user would see. The design pass is on
the critical path for the listing whether or not it is called polish.

## Principles, so the next pass does not relitigate

1. **During a conversation, the app's job is to be uninteresting.** Anything that pulls the eye off
   the person you are talking to is a defect, however charming.
2. **Restraint is the subject, so the interface should model it.** The loudest element on the
   listening screen was a filled red button.
3. **Touch before sight.** The user is not looking at the phone. Haptics are the correct channel for
   the two moments that matter.
4. **No delight that lies.** The calibration screen once drew a green checkmark and the word "Ready"
   over two failed readings. A warm empty state that overstates is the same defect wearing a nicer
   coat.

## The pass

| # | Change | Where | Why | Cost |
|---|---|---|---|---|
| 1 | **One accent colour, applied once at the root.** Moss green for within-intention and controls; amber for over-ceiling. Not system blue. | `Theme.swift`, `.tint()` in `OptiListenApp` | Green under / amber over is semantic rather than decorative: it says which side of your ceiling you are on without a label. Highest leverage line in the pass. | one file, one modifier |
| 2 | **The End button stops shouting.** Filled destructive red becomes bordered. | `PracticeLoopView` | It was the loudest thing on a screen about listening quietly. | one line |
| 3 | **The number breathes instead of ticking.** Display updates on the existing one-second timer with a short ease, rather than every 100 ms. | `ListeningStep` | A percentage twitching in peripheral vision is agitating in exactly the way this app must not be. The reading is unchanged; only its presentation settles. | ~5 lines |
| 4 | **Two haptics.** A soft tap the first time you cross your ceiling. A success notification when the loop closes. | `ListeningStep`, reflection `onDone` | The app is face-up on a desk and unwatched. Crossing your ceiling is the one thing worth interrupting for, and it should arrive through touch, not by making you look. | ~6 lines |
| 5 | **A closing moment.** The Home counter animates when it increments, and the new row appears rather than being there. | `HomeView` | Closing the loop is the entire payoff of the product and currently feels like cancelling a form. | ~3 lines |
| 6 | **No zero on first launch.** The counter section appears only once there is something to count. | `HomeView` | "0" in 52-point type is a poor first handshake for an app whose first screen should invite one conversation. | ~2 lines |

## Deliberately not doing

- **Animation on the listening screen** beyond the number settling. See principle 1.
- **Illustration or a mascot.** Not low-lift, and it dates.
- **A launch animation.** Nothing to celebrate at launch; the celebration belongs at the close.
- **Sound.** The app is listening. Making noise into a live microphone is self-defeating.

## Open for a later pass

- The app icon, recovered from Apple's CDN during the 2.0 (1) work. Worth asking whether it still
  represents a practice tool rather than a measurement tool.
- App Store screenshots, which need the 1.x structure (goal → live → reflection → reward) rebuilt on
  a current simulator. Required for submission.
- Onboarding. First launch drops you straight in, with calibration reachable but not routed to.
- The empty state's wording, which is serviceable rather than good.
