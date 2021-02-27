#!/bin/sh
set -e

sudo pacman -S --noconfirm --needed llvm clang
sudo pacman -S --noconfirm --needed rustup
sudo pacman -S --noconfirm --needed broot bandwhich fd bat diff-so-fancy
broot --install
yay -S --noconfirm --needed dust
