#!/usr/bin/env bash
# Removes what install.sh set up: NanoClaw through its own uninstaller, then the
# OneCLI gateway and its data. Slack apps the agents created stay in your
# workspace; remove them there.
set -euo pipefail

DIR="${NANOCLAW_DIR:-$HOME/nanoclaw-v2}"

if [ -x "$DIR/uninstall.sh" ]; then
  bash "$DIR/uninstall.sh" "$@"
  rm -rf "$DIR"
else
  echo "No NanoClaw copy in $DIR, skipping."
fi

if [ -f "$HOME/.onecli/docker-compose.yml" ]; then
  printf '\nRemove the OneCLI gateway and everything stored in it (~/.onecli)? [y/N] '
  read -r answer </dev/tty || answer=n
  case "$answer" in
    [yY]*) (cd "$HOME/.onecli" && env -u ONECLI_VERSION docker compose down -v) && rm -rf "$HOME/.onecli" ;;
    *) echo "Kept the gateway in ~/.onecli." ;;
  esac
fi
