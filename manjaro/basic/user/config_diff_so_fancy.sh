#!/bin/zsh
set -e

if which broot &>/dev/null; then
  broot --install
fi

# Configure git to use d-s-f for *all* diff operations
echo "config diff so fancy paget in git"
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"

echo "check if binary is exported, if no add this config to zprofile"
grep -qxF 'export PATH="$HOME/.cargo/bin:$PATH"' ~/.zprofile || echo 'export PATH="$HOME/.cargo/bin:$PATH"'>> ~/.zprofile
echo "update zshrc"
source ~/.zshrc || true
echo "update zprofile"
source ~/.zprofile
