#!/bin/sh
set -e

rm -rf ./.cargo
rm -rf ./.config/broot
rm -rf ./.config/pulse

sudo pacman -S --noconfirm llvm clang

curl https://sh.rustup.rs -sSf | sh -s -- -y
source $HOME/.cargo/env
cargo install -j$(nproc) broot
broot --install
#cargo install -j$(nproc) bandwhich
cargo install -j$(nproc) fd-find
cargo install -j$(nproc) du-dust
cargo install -j$(nproc) bat


grep -qxF 'source $HOME/.config/broot/launcher/bash/br' ~/.zshrc || echo 'source $HOME/.config/broot/launcher/bash/br'>> ~/.zshrc
grep -qxF 'export PATH="$HOME/.cargo/bin:$PATH"' ~/.zprofile || echo 'export PATH="$HOME/.cargo/bin:$PATH"'>> ~/.zprofile
source ~/.zshrc
source ~/.zprofile
