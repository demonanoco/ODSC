#!/usr/bin/env bash
# Step 2: get NanoClaw at the tested release, add the Sprint Team templates,
# and run NanoClaw's own installer against the gateway from step 1.
set -euo pipefail
. "$(dirname "${BASH_SOURCE[0]}")/common.sh"

REF="${NANOCLAW_REF:-v2026.10.1-rc.2}"
DIR="$(nanoclaw_dir "${1:-}")"
REPO_ROOT="$(git -C "$(dirname "${BASH_SOURCE[0]}")" rev-parse --show-toplevel 2>/dev/null || true)"
TEMPLATES="$(cd "$(dirname "${BASH_SOURCE[0]}")/../nanoclaw/sprint-team" && pwd)"

[ "$(onecli_version)" = "$ONECLI_VERSION_PIN" ] ||
  fail "OneCLI $ONECLI_VERSION_PIN isn't answering at $(onecli_url). Run setup/1-onecli.sh first."

case "$DIR/" in "$REPO_ROOT"/*) [ -n "$REPO_ROOT" ] && fail "$DIR is inside this repository. Pick a folder outside it, e.g. ~/nanoclaw-v2." ;; esac
say "NanoClaw goes in $DIR"

if [ -d "$DIR/.git" ]; then
  say "Using the NanoClaw copy in $DIR"
elif [ -e "$DIR" ]; then
  fail "$DIR exists and isn't a NanoClaw copy. Move it, or pass another folder."
else
  say "Getting NanoClaw $REF into $DIR"
  git clone --quiet --branch "$REF" https://github.com/nanocoai/nanoclaw.git "$DIR"
fi

say "Adding the Sprint Team templates"
mkdir -p "$DIR/templates"
rm -rf "$DIR/templates/sprint-team"
cp -R "$TEMPLATES" "$DIR/templates/sprint-team"

say "Running NanoClaw's installer"
echo "  Choose Slack, sign in to Claude, and at \"How should we create your first agent?\""
echo "  pick From local templates, then orchestrator."
cd "$DIR"
# Point setup at the running gateway, so it installs only the onecli command and
# leaves the gateway at 1.42 instead of installing its own pinned version.
NANOCLAW_ONECLI_API_HOST="$(onecli_url)" bash nanoclaw.sh
