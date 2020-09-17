#!/bin/sh
set -e

# reset if necessary
# sudo pacman-mirrors --country all --api --protocols all --set-branch stable && sudo pacman --noconfirm -Syyu
sudo pacman-mirrors --fasttrack && sudo pacman --noconfirm -Syyuu

