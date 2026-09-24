#!/usr/bin/env bash
# screenshots.sh — capture the six App Store shots from a Debug build in the Simulator.
#
# The app carries the scaffolding (OptiListen/Debug/ScreenshotFixture.swift, Debug builds only);
# this script only sequences launches and screenshots. The storyboard it implements is
# docs/store-content-2.0.md §3: six iPhone shots, 6.9" set (1320 × 2868), no iPad set — 1.1 was
# iPhone-only and 2.0 is TARGETED_DEVICE_FAMILY "1" from build (6).
#
# Usage:  scripts/screenshots.sh [simulator-name]      (default: "iPhone 17 Pro Max" = 6.9")
# Output: Screenshots/<date>/shot-N-<name>.png, plus the sizes printed at the end so the
#         Apple spec can be checked against the files rather than assumed.
#
# Every step ends with a READ (the file exists and has the right pixel size); the script
# never reports success from an exit code alone.
set -u
SIM="${1:-iPhone 17 Pro Max}"
BUNDLE="com.longskymedia.optilisten"
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
OUT="$ROOT/Screenshots/$(date +%F)"
mkdir -p "$OUT"

UDID=$(xcrun simctl list devices available -j | python3 -c "
import sys, json
for runtime, devs in json.load(sys.stdin)['devices'].items():
    for d in devs:
        if d['name'] == '$SIM' and d['isAvailable']: print(d['udid']); sys.exit()
")
[ -n "$UDID" ] || { echo "no available simulator named '$SIM'"; exit 2; }
echo "simulator: $SIM ($UDID)"

echo "== build (Debug, simulator) =="
xcodebuild -project "$ROOT/OptiListen.xcodeproj" -scheme OptiListen -configuration Debug \
  -destination "platform=iOS Simulator,id=$UDID" -derivedDataPath "$ROOT/.build-screenshots" \
  -quiet build || { echo "build failed"; exit 1; }
APP=$(find "$ROOT/.build-screenshots/Build/Products/Debug-iphonesimulator" -maxdepth 1 -name "OptiListen.app" | head -1)
[ -d "$APP" ] || { echo "built app not found"; exit 1; }

xcrun simctl boot "$UDID" 2>/dev/null || true
xcrun simctl bootstatus "$UDID" -b >/dev/null
# Fresh container: shot 1 is Home with nothing in it, and the seed only fills an empty store.
xcrun simctl uninstall "$UDID" "$BUNDLE" 2>/dev/null || true
xcrun simctl install "$UDID" "$APP"
# Status bar the reviewers expect: 9:41, full signal, full battery.
# `unplugged`, not `charged`: `charged` draws the green cell and the lightning bolt, which put a
# charging battery in all six of the first 09-23 shots — caught by Cairn, who opened the images
# rather than reading my capture log. Apple's own marketing shots use the quiet full battery.
xcrun simctl status_bar "$UDID" override --time "9:41" --batteryState unplugged --batteryLevel 100 --cellularBars 4 --wifiBars 3 2>/dev/null || true

shot() {  # shot <n> <name> <settle-seconds> <launch args…>
  local n="$1" name="$2" settle="$3"; shift 3
  xcrun simctl terminate "$UDID" "$BUNDLE" 2>/dev/null || true
  xcrun simctl launch "$UDID" "$BUNDLE" "$@" >/dev/null
  sleep "$settle"
  local f="$OUT/shot-$n-$name.png"
  xcrun simctl io "$UDID" screenshot --type=png "$f" >/dev/null 2>&1
  local size; size=$(sips -g pixelWidth -g pixelHeight "$f" 2>/dev/null | awk '/pixel/{printf "%s ", $2}')
  echo "shot $n $name → $(basename "$f")  ${size:-MISSING}"
}

FOCUS="Ask before answering."
shot 1 home-empty        3
shot 2 before            3 -screenshot-step intention  -screenshot-focus "$FOCUS" -screenshot-label "Roadmap review"
shot 3 listening-within  4 -screenshot-step listening  -screenshot-focus "$FOCUS" -screenshot-label "Roadmap review" -screenshot-fixture 0.22 -screenshot-elapsed 390
shot 4 listening-over    4 -screenshot-step listening  -screenshot-focus "$FOCUS" -screenshot-label "Roadmap review" -screenshot-fixture 0.41 -screenshot-elapsed 720
shot 5 after             4 -screenshot-step reflection -screenshot-focus "$FOCUS" -screenshot-label "Roadmap review" -screenshot-fixture 0.24 -screenshot-elapsed 1500 -screenshot-presence 4
shot 6 home-history      3 -screenshot-seed

xcrun simctl status_bar "$UDID" clear 2>/dev/null || true
# Shut the Simulator down. It boots one and, before 2026-09-24, never put it back: the device from
# the previous evening's run was still booted the next morning, two CoreSimulator processes at ~22%
# CPU each, showing up as host load on a machine that runs 25 agent sessions. A capture tool that
# leaves a device running is charging its convenience to everything else on the box.
xcrun simctl shutdown "$UDID" 2>/dev/null || true
echo "== files =="
ls -la "$OUT"
echo "Expected for the 6.9\" set: 1320 2868 (portrait). Anything else means the wrong simulator or a scale mismatch — check before uploading."
