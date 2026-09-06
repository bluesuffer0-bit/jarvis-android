#!/bin/bash
# Push the Brain vault to a private GitHub repo so the phone copy shares one memory.
# Usage (Git Bash on the PC): bash sync-vault-to-git.sh https://github.com/YOU/brain-vault.git
# SPDX-License-Identifier: AGPL-3.0-or-later
set -e
URL="${1:?usage: sync-vault-to-git.sh <private-repo-url>}"
cd "/c/Users/RDP/Brain"

git rev-parse --git-dir >/dev/null 2>&1 || git init -q -b main
if ! git rev-parse --verify main >/dev/null 2>&1; then git checkout -q -b main; fi

# Obsidian's workspace file is per-device UI state, never memory.
if [ ! -f .gitignore ]; then
  printf '.obsidian/workspace.json\n.obsidian/workspace-mobile.json\n' > .gitignore
fi

git add -A
git commit -q -m "Vault sync $(date +%Y-%m-%d)" --allow-empty
git remote remove origin 2>/dev/null || true
git remote add origin "$URL"
git push -q -u origin main
echo "Vault pushed to $URL"
echo "Give that same URL to the phone setup script."
