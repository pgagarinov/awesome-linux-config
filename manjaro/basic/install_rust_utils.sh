#!/bin/sh
set -e

rm -rf ~/.cargo
rm -rf ~/.rustup
sudo pacman -S --noconfirm --needed llvm clang
sudo pacman -S --noconfirm --needed rustup
rustup default stable
rustup component add rls rustfmt rust-analysis rust-src
sudo pacman -S --noconfirm --needed broot bandwhich fd bat diff-so-fancy
broot --install
yay -S --noconfirm --needed dust
