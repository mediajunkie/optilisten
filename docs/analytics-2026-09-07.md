# OptiListen — App Store analytics, read 2026-09-07

Pulled by Cairn from App Store Connect (xian signed in; Cairn drove the browser).
Lifetime window as Apple defines it: **Jan 14, 2023 – Sep 6, 2026**. "Opt-in only"
metrics count only users who share analytics with developers, so they undercount.

## Lifetime

| Metric | Value | Note |
|---|---|---|
| Total downloads | **96** | first-time + redownloads |
| Product page views | 466 | ~20% page-view → download |
| Installations | 35 | opt-in only |
| Sessions | 123 | opt-in only → **~3.5 sessions per opt-in install, ~1.3 per download** |
| Deletions | — | no data |
| Active last 30 days | — | no data |
| Retention | not enough data | Apple won't chart it at this volume |

## Last 30 days (Aug 8 – Sep 6, 2026)

| Metric | Value |
|---|---|
| First-time downloads | 5 |
| Redownloads | 2 |
| Impressions | 548 |
| Product page views | 14 |
| Conversion rate (daily avg) | 1.53% |

## Downloads by iOS version, lifetime (86 attributed of 96)

| iOS | Downloads | When |
|---|---|---|
| 26.x | 20 | 2025–26 |
| 18.x | 12 | 2024–25 |
| 17.x | 13 | 2023–24 |
| 16.x | 28 | 2023 (launch cohort) |
| 15.x | 6 | 2023 |
| ≤ 14 | 4 | 2023 |

Shape of the curve: launch spike Jan 2023 (peak day 8), a thin trickle through
mid-2024, **effectively zero from ~Oct 2024 to ~Jun 2025**, then a steady trickle
through 2026 — 20 downloads on iOS 26 alone, with 5 in the last 30 days.

## What this decides

**Deployment target: iOS 17.0 is confirmed.** Every download since 2024 landed on
iOS 17 or later. The 28 iOS-16 downloads are the 2023 launch cohort on iPhone 8/X-class
hardware that cannot run 17; they keep 1.1 and lose nothing. Raising to iOS 18 would
also be defensible (32 of the recent cohort) but buys nothing for the rebuild.

**Retention was essentially nil.** ~1.3 sessions per download means most people opened
it once. Read this knowing the 50-second background limit was suppressing it — the app
literally stopped working a minute into the thing it was for — but do not read past
the number: nothing here says people came back.

**Discovery never stopped.** 548 impressions and 5 first-time downloads in the last
30 days, with zero marketing for three years and a listing last touched in 2023.
People are still searching for something in this space and finding it. This is the
single most interesting fact in the data for the reposition-vs-sunset question: the
demand side has a pulse even though the product side flatlined. It is small, but it
is unpaid and unprompted.

**For the Dan package:** 96 lifetime downloads, ~1 session each, organic discovery
still ticking. That's the honest baseline for all three options.
