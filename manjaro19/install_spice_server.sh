#!/bin/sh
set -e
sudo pacman -S --noconfirm --needed yay base-devel spice
yay -S --noconfirm --needed xf86-video-qxl python2 spice-vdagent