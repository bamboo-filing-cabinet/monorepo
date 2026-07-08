#!/bin/bash
# Sync AND advance the monorepo workspace and all submodules.
#
# Unlike a plain `git submodule foreach 'git fetch'`, this fast-forwards
# everything to the latest published commits:
#   1. Fast-forward the superproject (this repo) to its upstream.
#   2. Sync + init submodules (picks up any newly added ones).
#   3. Advance each submodule to the tip of its tracked branch.
#
# Options:
#   --commit   Commit the resulting submodule pointer bumps.
#   --push     Push the superproject after committing (implies --commit).
#   -h|--help  Show this help.

set -euo pipefail

COMMIT=false
PUSH=false
for arg in "$@"; do
  case "$arg" in
    --commit) COMMIT=true ;;
    --push)   COMMIT=true; PUSH=true ;;
    -h|--help) sed -n '2,/^set /{/^set /d;s/^# \{0,1\}//;p;}' "$0"; exit 0 ;;
    *) echo "Unknown option: $arg" >&2; exit 1 ;;
  esac
done

cd "$(git rev-parse --show-toplevel)"

echo "==> Fast-forwarding superproject..."
git pull --ff-only

echo "==> Syncing submodule URLs and initializing..."
git submodule sync --recursive >/dev/null
git submodule update --init --recursive

echo "==> Advancing each submodule to its branch tip..."
git submodule foreach '
  branch=$(git config -f "$toplevel/.gitmodules" "submodule.$name.branch" 2>/dev/null || true)
  if [ -z "$branch" ]; then
    branch=$(git remote show origin | sed -n "s/.*HEAD branch: //p")
  fi
  echo "  [$name] -> origin/$branch"
  git fetch -q origin
  git checkout -q "$branch"
  git pull -q --ff-only origin "$branch"
'

echo "==> Submodule status:"
git submodule status

if [ "$COMMIT" = true ]; then
  echo "==> Staging submodule pointer bumps..."
  git submodule foreach -q 'git -C "$toplevel" add -- "$sm_path"'
  if git diff --cached --quiet; then
    echo "  Pointers unchanged; nothing to commit."
  else
    git commit -m "chore: advance submodules to latest"
    echo "  Committed pointer bumps."
    if [ "$PUSH" = true ]; then
      echo "==> Pushing..."
      git push
    fi
  fi
fi

echo "Done."
