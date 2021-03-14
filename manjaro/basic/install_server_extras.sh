#!/bin/sh

set -e
# pgAdming db client for PostgreSQL
yay -S pgadmin4 --noconfirm --needed

# Stack Haskell platform (dependency for ERD)
yay -S --noconfirm --needed stack

# FAR for Linux
yay -S --needed --nocleanmenu  --nodiffmenu --noconfirm far2l-git
