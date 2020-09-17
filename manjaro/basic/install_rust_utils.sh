#!/bin/sh
set -e

sudo pacman -S --noconfirm --needed llvm clang
sudo pacman -S --noconfirm --needed rustup
rustup default stable
rustup component add rls
rustup component add rustfmt
sudo pacman -S --noconfirm --needed broot bandwhich fd bat diff-so-fancy
broot --install
yay -S --noconfirm --needed dust
