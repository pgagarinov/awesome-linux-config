#!/bin/sh
set -e

sudo pacman -S --noconfirm --needed llvm clang
sudo pacman -S --noconfirm --needed rustup

rustup default stable

sudo pacman -S --noconfirm --needed broot bandwhich fd bat diff-so-fancy lsd skim
broot --install
yay -S --noconfirm --needed --nocleanmenu --nodiffmenu dust
