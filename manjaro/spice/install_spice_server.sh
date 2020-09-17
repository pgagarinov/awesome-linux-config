#!/bin/sh
set -e
sudo pacman -R --noconfirm xf86-video-*
sudo pacman -S --noconfirm --needed yay base-devel spice
yay -S --noconfirm --needed xf86-video-qxl python2 spice-vdagent
sudo cp spiceqxl.xorg.conf /etc/X11/
Xspice :0 --config /etc/X11/spiceqxl.xorg.conf --xsession startplasma-x11 > ~/.local/share/xorg/Xspice.log
