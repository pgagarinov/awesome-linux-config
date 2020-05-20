#!/bin/sh
set -e
sudo dnf install python3-pip

grep -qxF 'export PATH=$HOME/.local/bin:$PATH' ~/.zshrc || echo 'export PATH=$HOME/.local/bin:$PATH'>> ~/.zshrc
