#!/bin/sh
set -e
sudo pacman -S --noconfirm git git-lfs
git config --global user.name "Your Name"
git config --global user.email "your@email"
