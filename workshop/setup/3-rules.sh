#!/usr/bin/env bash
# Step 3: the two gateway rules. Merging a pull request waits for your approval;
# GitHub GraphQL is blocked, so a merge can't take that route around the first rule.
# Safe to run again: a rule that already exists is left alone.
set -euo pipefail
. "$(dirname "${BASH_SOURCE[0]}")/common.sh"

URL="$(onecli_url)"
[ -n "$(onecli_version)" ] || fail "OneCLI isn't answering at $URL. Run setup/1-onecli.sh first."

existing=$(curl -fsS -m 10 "$URL/v1/policy/rules") ||
  fail "Couldn't read the rules. Add them by hand in the dashboard ($URL), under Rules."

add_rule() {
  local name="$1" body="$2"
  if printf '%s' "$existing" | grep -qF "\"name\":\"$name\""; then
    echo "  = $name (already there)"
    return
  fi
  curl -fsS -m 10 -X POST "$URL/v1/policy/rules" -H 'Content-Type: application/json' -d "$body" >/dev/null ||
    fail "Couldn't add \"$name\". Add it by hand in the dashboard ($URL), under Rules."
  echo "  + $name"
}

say "Adding the gateway rules"
add_rule "Merging a pull request needs approval" \
  '{"name":"Merging a pull request needs approval","action":"allow","requireApproval":true,"targets":[{"kind":"network","hostPattern":"api.github.com","pathPattern":"/repos/*/*/pulls/*/merge","method":"PUT"}]}'
add_rule "No GitHub GraphQL" \
  '{"name":"No GitHub GraphQL","action":"block","targets":[{"kind":"network","hostPattern":"api.github.com","pathPattern":"/graphql","method":"POST"}]}'

curl -fsS -m 10 -X POST "$URL/v1/policy/publish" -H 'Content-Type: application/json' -d '{}' >/dev/null ||
  fail "The rules were saved but not published. Publish them in the dashboard ($URL), under Rules."

say "Rules are live. Everything else the agents do is allowed."
