#!/usr/bin/env bash
# Sync KDE configs between the live session and this repo.
#
# KDE is NOT stowed. KConfig saves by writing a temp file and renaming it over
# the target, which destroys a symlink and leaves a real file in its place. A
# stowed KDE config silently stops tracking the moment you touch System
# Settings, so these files are copied, not linked.
#
#   ./sync.sh pull   live -> repo   (capture changes you made in System Settings)
#   ./sync.sh push   repo -> live   (restore onto a fresh machine)
#   ./sync.sh diff   show what differs

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/config"
LIVE_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"

FILES=(
  kwinrc
  kglobalshortcutsrc
  krdpserverrc
)

usage() { sed -n '2,12p' "${BASH_SOURCE[0]}" | sed 's/^# \{0,1\}//'; exit 1; }

[[ $# -eq 1 ]] || usage

case "$1" in
  pull)
    for f in "${FILES[@]}"; do
      if [[ -f "$LIVE_DIR/$f" ]]; then
        cp -p "$LIVE_DIR/$f" "$REPO_DIR/$f"
        echo "pulled  $f"
      else
        echo "skipped $f (not present in $LIVE_DIR)"
      fi
    done
    echo
    echo "Review with 'git diff' before committing."
    ;;

  push)
    # kwin/kglobalaccel hold these in memory and rewrite them on logout, so a
    # push into a running Plasma session gets clobbered. Only safe pre-login.
    if pgrep -x kwin_wayland >/dev/null 2>&1 || pgrep -x kwin_x11 >/dev/null 2>&1; then
      echo "WARNING: Plasma is running. It will overwrite these files on logout." >&2
      echo "Log out to a TTY and push from there, or change shortcuts via System Settings." >&2
      read -rp "Push anyway? [y/N] " reply
      [[ "$reply" == [yY] ]] || { echo "aborted"; exit 1; }
    fi
    for f in "${FILES[@]}"; do
      if [[ -f "$REPO_DIR/$f" ]]; then
        [[ -f "$LIVE_DIR/$f" ]] && cp -p "$LIVE_DIR/$f" "$LIVE_DIR/$f.bak"
        cp -p "$REPO_DIR/$f" "$LIVE_DIR/$f"
        echo "pushed  $f"
      fi
    done
    ;;

  diff)
    for f in "${FILES[@]}"; do
      if [[ -f "$REPO_DIR/$f" && -f "$LIVE_DIR/$f" ]]; then
        if diff -q "$REPO_DIR/$f" "$LIVE_DIR/$f" >/dev/null; then
          echo "same     $f"
        else
          echo "DIFFERS  $f"
          diff -u "$REPO_DIR/$f" "$LIVE_DIR/$f" | sed 's/^/    /' || true
        fi
      fi
    done
    ;;

  *) usage ;;
esac
