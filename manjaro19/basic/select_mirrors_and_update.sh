#!/bin/sh
set -e
# reset if necessary
# sudo pacman-mirrors --country all --api --protocols all --set-branch stable && sudo pacman -Syyu
sudo pacman-mirrors --fasttrack && sudo pacman -Syyu
