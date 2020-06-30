#!/bin/sh
set -e

# Configure git to use d-s-f for *all* diff operations
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"

grep -qxF 'export PATH="$HOME/.cargo/bin:$PATH"' ~/.zprofile || echo 'export PATH="$HOME/.cargo/bin:$PATH"'>> ~/.zprofile
source ~/.zshrc
source ~/.zprofile
