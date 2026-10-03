#!/usr/bin/env bash
# release.sh — build, verify and upload an OptiListen TestFlight build, refusing at every gate
# that has actually bitten us rather than at every gate imaginable.
#
# WHY THIS EXISTS (2026-10-02, after shipping 2.0 (7) the slow way)
#
# The knowledge was never missing. When this went wrong today, the correct procedure existed in
# THREE places: a 09-11 log entry diagnosing the exact failure, a 09-11 memo from Cairn recording
# the same error string, and a working exportOptions.plist committed in this repo. A fourth
# document would not have helped. What was missing was the procedure being *executable at the
# moment of need*, so this is a script rather than a runbook.
#
# EVERY GATE BELOW IS A MISTAKE SOMEONE ACTUALLY MADE, with the date. That is the selection rule:
# if it has not bitten, it is not here.
#
#   behind-origin   10-02: local checkout was 22 commits behind and still said
#                   CURRENT_PROJECT_VERSION 6. Building on it would have produced a build 6 while
#                   the operator reported 7. Three sources disagreeing is the only reason it
#                   surfaced.
#   version-agree   the committed pbxproj is GENERATED and drifts (it sat at 5 while project.yml
#                   said 7). project.yml is the truth; xcodegen reconciles; this asserts it did.
#   export-options  10-02: a hand-written exportOptions.plist omitted `signingStyle`, which
#                   DEFAULTS TO AUTOMATIC, which means CLOUD signing -- a permission this project
#                   has never had. It reproduced verbatim the "No profiles for
#                   'com.longskymedia.optilisten' were found" already diagnosed on 09-11. The
#                   committed file is used; a hand-written one is never accepted.
#   team-id         10-02: the API KEY id (D96QY6RRB3) was passed as the TEAM id (YZ4B34YGX9).
#                   Both are opaque uppercase strings, which is why it looked right.
#   distribution    an archive is Apple DEVELOPMENT signed. "ARCHIVE SUCCEEDED" is not
#                   "uploadable", and the difference is invisible unless asserted.
#   issuer          09-21's upload used an issuer id that was then written down only as
#                   "4d7298e0-..." -- truncated -- in two memos. On 10-02 that cost a false
#                   escalation to xian for a value already on the host. It now lives at a fixed
#                   path and this script names that path when it is missing.
#
# A NOTE ON WHY THE VERIFICATION LOOKS PARANOID
# Every figure printed here is read back out of the ARTIFACT -- the archive's plist, the IPA's own
# plist after unzipping, codesign on the unpacked app -- never off an exit code and never off the
# build log. `xcodebuild` prints "** EXPORT FAILED **" and the shell still reported 0 on 10-02,
# because the status was read through a pipe. Statuses here are captured before anything else runs.
#
# USAGE
#   scripts/release.sh                 # build, verify, upload
#   scripts/release.sh --no-upload     # build and verify only; stop before TestFlight
#   scripts/release.sh --allow-behind  # proceed despite being behind origin (say why in the log)
#
# EXIT  0 ok · 1 a gate refused · 2 something could not be measured

set -uo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO" || exit 2

BUNDLE_ID="com.longskymedia.optilisten"
API_KEY_ID="D96QY6RRB3"                                  # the KEY. Not the team.
ISSUER_FILE="${ISSUER_FILE:-$HOME/.appstoreconnect/issuer_id}"
KEY_FILE="$HOME/.appstoreconnect/private_keys/AuthKey_${API_KEY_ID}.p8"
EXPORT_OPTS="$REPO/exportOptions.plist"

do_upload=1; allow_behind=0
while [ $# -gt 0 ]; do
  case "$1" in
    --no-upload)    do_upload=0 ;;
    --allow-behind) allow_behind=1 ;;
    -h|--help) sed -n '2,45p' "$0"; exit 0 ;;
    *) printf 'release: unknown argument: %s\n' "$1" >&2; exit 1 ;;
  esac
  shift
done

say()    { printf '\n=== %s\n' "$*"; }
refuse() { printf '\nREFUSED: %s\n' "$1" >&2; [ $# -gt 1 ] && printf '  do this: %s\n' "$2" >&2; exit 1; }
unmeas() { printf '\nUNMEASURABLE: %s\n' "$1" >&2; exit 2; }

# ---------------------------------------------------------------- gate: behind origin
say "gate: is this checkout current?"
if ! git fetch origin --quiet 2>/dev/null; then
  unmeas "cannot fetch origin, so I cannot tell whether this checkout is current"
fi
behind="$(git rev-list --count HEAD..origin/main 2>/dev/null)" || unmeas "cannot count commits behind origin/main"
printf 'behind origin/main: %s\n' "$behind"
if [ "${behind:-0}" -gt 0 ] && [ "$allow_behind" -eq 0 ]; then
  refuse "this checkout is $behind commit(s) behind origin/main" \
         "git pull --ff-only origin main   (on 10-02 a 22-commit lag still read CURRENT_PROJECT_VERSION 6 while main was at 7)"
fi

# ---------------------------------------------------------------- gate: versions agree
say "gate: regenerate, then make the version sources agree"
want="$(sed -n 's/^[[:space:]]*CURRENT_PROJECT_VERSION:[[:space:]]*"\{0,1\}\([0-9][0-9]*\)"\{0,1\}[[:space:]]*$/\1/p' project.yml | head -1)"
[ -n "$want" ] || unmeas "could not read CURRENT_PROJECT_VERSION from project.yml, which is the build-number truth"
marketing="$(sed -n 's/^[[:space:]]*MARKETING_VERSION:[[:space:]]*"\{0,1\}\([0-9.][0-9.]*\)"\{0,1\}[[:space:]]*$/\1/p' project.yml | head -1)"
printf 'project.yml says: %s (%s)\n' "$marketing" "$want"

command -v xcodegen >/dev/null 2>&1 || refuse "xcodegen is not installed" "brew install xcodegen"
xcodegen generate >/dev/null 2>&1 || refuse "xcodegen generate failed" "run it directly to see why"

got="$(sed -n 's/.*CURRENT_PROJECT_VERSION = \([0-9][0-9]*\);.*/\1/p' OptiListen.xcodeproj/project.pbxproj | sort -u | tr '\n' ' ')"
got="${got% }"
[ "$got" = "$want" ] || refuse "after xcodegen the pbxproj says '$got' but project.yml says '$want'" \
                               "the pbxproj is generated; if these disagree the generator did not run on this file"
printf 'pbxproj agrees: %s\n' "$got"

# ---------------------------------------------------------------- archive
say "archive"
ARCH="$REPO/build/release-$want.xcarchive"
rm -rf "$ARCH"
xcodebuild -project OptiListen.xcodeproj -scheme OptiListen -configuration Release \
  -destination 'generic/platform=iOS' -archivePath "$ARCH" archive > "$REPO/build/archive-$want.log" 2>&1
arc_rc=$?                               # captured IMMEDIATELY -- a pipe here would read the wrong status
[ "$arc_rc" -eq 0 ] || refuse "archive failed (rc=$arc_rc)" "read build/archive-$want.log"

APP="$ARCH/Products/Applications/OptiListen.app"
[ -d "$APP" ] || unmeas "archive reported success but $APP does not exist"
a_id="$(/usr/libexec/PlistBuddy -c 'Print :CFBundleIdentifier' "$APP/Info.plist" 2>/dev/null)"
a_bv="$(/usr/libexec/PlistBuddy -c 'Print :CFBundleVersion' "$APP/Info.plist" 2>/dev/null)"
printf 'archive artifact: %s / %s\n' "$a_id" "$a_bv"
[ "$a_id" = "$BUNDLE_ID" ] || refuse "archive bundle id is '$a_id', expected '$BUNDLE_ID'"
[ "$a_bv" = "$want" ]      || refuse "archive build is '$a_bv', expected '$want'"

# ---------------------------------------------------------------- export
say "export (committed exportOptions.plist only)"
[ -f "$EXPORT_OPTS" ] || refuse "no exportOptions.plist in the repo" \
  "do NOT hand-write one: the default signingStyle is 'automatic', which means CLOUD signing, a permission this project has never had"
style="$(/usr/libexec/PlistBuddy -c 'Print :signingStyle' "$EXPORT_OPTS" 2>/dev/null)"
[ "$style" = "manual" ] || refuse "exportOptions.plist signingStyle is '${style:-unset}', not 'manual'" \
  "automatic means cloud signing and fails with 'No profiles for $BUNDLE_ID were found' (diagnosed 09-11, repeated 10-02)"

OUT="$REPO/build/release-$want-export"
rm -rf "$OUT"
xcodebuild -exportArchive -archivePath "$ARCH" -exportOptionsPlist "$EXPORT_OPTS" -exportPath "$OUT" \
  > "$REPO/build/export-$want.log" 2>&1
exp_rc=$?
[ "$exp_rc" -eq 0 ] || refuse "export failed (rc=$exp_rc)" "read build/export-$want.log"

IPA="$OUT/OptiListen.ipa"
[ -f "$IPA" ] || unmeas "export reported success but $IPA does not exist"

# ---------------------------------------------------------------- gate: the IPA, not the log
say "verify the IPA itself"
TMPD="$(mktemp -d)"; trap 'rm -rf "$TMPD"' EXIT
unzip -q "$IPA" -d "$TMPD" || unmeas "could not unzip the IPA to verify it"
UAPP="$(ls -d "$TMPD"/Payload/*.app 2>/dev/null | head -1)"
[ -n "$UAPP" ] || unmeas "no .app inside the IPA"
i_id="$(/usr/libexec/PlistBuddy -c 'Print :CFBundleIdentifier' "$UAPP/Info.plist" 2>/dev/null)"
i_bv="$(/usr/libexec/PlistBuddy -c 'Print :CFBundleVersion' "$UAPP/Info.plist" 2>/dev/null)"
i_mv="$(/usr/libexec/PlistBuddy -c 'Print :CFBundleShortVersionString' "$UAPP/Info.plist" 2>/dev/null)"
auth="$(codesign -dvv "$UAPP" 2>&1 | sed -n 's/^Authority=//p' | head -1)"
printf 'IPA: %s / %s (%s), %s bytes\n' "$i_id" "$i_bv" "$i_mv" "$(wc -c < "$IPA" | tr -d ' ')"
printf 'signed by: %s\n' "$auth"
[ "$i_id" = "$BUNDLE_ID" ] || refuse "IPA bundle id is '$i_id', expected '$BUNDLE_ID'"
[ "$i_bv" = "$want" ]      || refuse "IPA build is '$i_bv', expected '$want'"
case "$auth" in
  "Apple Distribution"*) : ;;
  *) refuse "the IPA is signed '$auth', not Apple Distribution" \
            "an ARCHIVE is Development-signed; only the export re-signs it. 'ARCHIVE SUCCEEDED' never means uploadable." ;;
esac

if [ "$do_upload" -eq 0 ]; then
  printf '\nOK: %s build %s verified at %s\n' "$i_mv" "$i_bv" "$IPA"
  printf 'upload skipped (--no-upload)\n'
  exit 0
fi

# ---------------------------------------------------------------- upload
say "upload to TestFlight"
[ -f "$KEY_FILE" ] || refuse "no API key at $KEY_FILE" "the key id is $API_KEY_ID; place AuthKey_${API_KEY_ID}.p8 there, chmod 600"
[ -s "$ISSUER_FILE" ] || refuse "no issuer id at $ISSUER_FILE" \
  "App Store Connect -> Users and Access -> Integrations -> App Store Connect API; the Issuer ID is above the key table. Then: echo '<uuid>' > $ISSUER_FILE && chmod 600 $ISSUER_FILE"
issuer="$(tr -d '[:space:]' < "$ISSUER_FILE")"
case "$issuer" in
  ????????-????-????-????-????????????) : ;;
  *) refuse "the issuer id at $ISSUER_FILE is not a UUID (${#issuer} chars)" "re-copy it; it is a UUID, and it is NOT the key id ($API_KEY_ID)" ;;
esac

xcrun altool --upload-app -f "$IPA" -t ios --apiKey "$API_KEY_ID" --apiIssuer "$issuer" > "$REPO/build/upload-$want.log" 2>&1
up_rc=$?
if [ "$up_rc" -ne 0 ]; then
  printf '\n'; tail -15 "$REPO/build/upload-$want.log" >&2
  refuse "upload failed (rc=$up_rc)" "full output in build/upload-$want.log"
fi
# altool has been known to print errors and still exit 0, so assert the success line too.
if ! grep -c 'UPLOAD SUCCEEDED' "$REPO/build/upload-$want.log" > /dev/null 2>&1; then
  tail -15 "$REPO/build/upload-$want.log" >&2
  refuse "altool exited 0 but did not print UPLOAD SUCCEEDED" "read build/upload-$want.log before assuming it shipped"
fi

printf '\nUPLOADED %s build %s\n' "$i_mv" "$i_bv"
sed -n 's/^Delivery UUID: /delivery UUID: /p' "$REPO/build/upload-$want.log"
printf 'Apple processing takes ~5-15 min; internal TestFlight groups then receive it automatically.\n'
printf 'Remember: bump CURRENT_PROJECT_VERSION in project.yml before the next build.\n'
exit 0
