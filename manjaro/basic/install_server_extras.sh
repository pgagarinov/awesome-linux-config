#!/bin/sh

set -e
# Stack Haskell platform (dependency for ERD)
yay -S --noconfirm --needed stack

# FAR for Linux
# disabled for now as this AUR package is broken
#yay -S --needed --nocleanmenu  --nodiffmenu --noconfirm far2l-git
