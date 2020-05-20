#!/bin/sh
set -e

sudo pacman -S --noconfirm llvm clang
sudo pacman -S --noconfirm rustup
rustup default stable
rustup component add rls
rustup component add rustfmt
sudo pacman -S --noconfirm broot bandwhich fd bat diff-so-fancy
broot --install
yay -S --noconfirm dust

# Configure git to use d-s-f for *all* diff operations
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"

grep -qxF 'export PATH="$HOME/.cargo/bin:$PATH"' ~/.zprofile || echo 'export PATH="$HOME/.cargo/bin:$PATH"'>> ~/.zprofile
source ~/.zshrc
source ~/.zprofile
