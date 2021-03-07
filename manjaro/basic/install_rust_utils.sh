#!/bin/sh
set -e

sudo pacman -S --noconfirm --needed llvm clang
sudo pacman -S --noconfirm --needed rustup
sudo pacman -S --noconfirm --needed broot bandwhich fd bat diff-so-fancy exa
broot --install
yay -S --noconfirm --needed dust
