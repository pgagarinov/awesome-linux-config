#!/bin/bash
set -e
rm -rf ~/.cargo
rm -rf ~/.rustup
rustup default stable
rustup component add rls rustfmt rust-analysis rust-src
