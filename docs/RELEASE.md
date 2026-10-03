# Releasing an OptiListen TestFlight build

```sh
scripts/release.sh                 # build, verify, upload
scripts/release.sh --no-upload     # build and verify only
```

**Before you start:** bump `CURRENT_PROJECT_VERSION` in `project.yml`. That file is the build-number
truth; the committed `.pbxproj` is generated and will be out of date, which is normal.

That is the whole procedure. **This document deliberately does not restate the steps** — the steps are
in the script, and the reason the script exists is that a written procedure did not survive contact with
the moment of use. On 2026-10-02 the correct method existed in three places (a 09-11 log entry, a 09-11
memo, and a committed `exportOptions.plist`) and was still not followed. A fourth place would not have
helped.

## What each refusal means

Every gate below is a mistake that actually happened, with its date. If it never bit, it is not a gate.

| Refusal | What went wrong | What to do |
|---|---|---|
| **behind origin/main** | 10-02: the checkout was 22 commits behind and still read `CURRENT_PROJECT_VERSION 6`. Building would have shipped a 6 labelled 7. | `git pull --ff-only origin main`. Use `--allow-behind` only deliberately. |
| **pbxproj disagrees with project.yml** | The `.pbxproj` is generated and drifts — it sat at 5 while `project.yml` said 7. | `xcodegen generate` should fix it; if it does not, the generator did not run on that file. |
| **exportOptions signingStyle is not `manual`** | 10-02: a hand-written options plist omitted `signingStyle`, which **defaults to automatic**, which means **cloud signing** — a permission this project has never had. It reproduced the exact `No profiles for com.longskymedia.optilisten were found` already diagnosed on 09-11. | Use the committed `exportOptions.plist`. Never hand-write one. |
| **IPA is not Apple Distribution signed** | An archive is **Development**-signed. `** ARCHIVE SUCCEEDED **` does not mean uploadable, and nothing says so unless you check. | Only the export re-signs. If this fires, the export did not do its job. |
| **no issuer id** | 09-21's upload used an issuer that was then written down only as `4d7298e0-…`, truncated, in two memos. On 10-02 that cost a false escalation for a value already on the host. | App Store Connect → Users and Access → Integrations → App Store Connect API. The Issuer ID sits above the key table. Then `echo '<uuid>' > ~/.appstoreconnect/issuer_id && chmod 600 ~/.appstoreconnect/issuer_id`. |
| **issuer is not a UUID** | 10-02: the **API key id** (`D96QY6RRB3`) was passed where the **team id** (`YZ4B34YGX9`) belonged. Both are opaque uppercase strings, which is why it looked right. | The issuer is a UUID. The key id is not the issuer and not the team. |

## Credentials, and why they live where they do

- **`~/.appstoreconnect/private_keys/AuthKey_D96QY6RRB3.p8`** — the actual secret, mode `0600`. On disk
  in the clear because that is Apple's documented convention: `altool`, `notarytool` and `xcodebuild`
  all look in that directory. `altool`'s only keychain option (`--store-password-in-keychain-item`)
  covers the Apple-ID/app-specific-password path, **not** API keys, so the keychain is not available for
  this half.
- **`~/.appstoreconnect/issuer_id`** — an identifier, not a secret: a UUID naming the team the key
  belongs to, displayed openly in the App Store Connect UI and useless without the `.p8`.

**Known gap, not yet addressed:** nothing tracks the API key's validity. If it is revoked or rotated we
find out when a release fails.

## After a successful upload

Apple processes for ~5–15 minutes, then internal TestFlight groups receive the build automatically — no
per-tester step. Bump `project.yml` before the next build.
