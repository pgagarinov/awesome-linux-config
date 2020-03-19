#!/bin/sh
set -e
sudo pacman -S --noconfirm git git-lfs
git config --global user.name "Peter Gagarinov"
git config --global user.email "pgagarinov@gmail.com"
