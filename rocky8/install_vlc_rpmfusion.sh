#!/bin/sh
set -e
./setup_rpmfusion.sh
#
sudo dnf install http://rpmfind.net/linux/epel/7/x86_64/Packages/s/SDL2-2.0.10-1.el7.x86_64.rpm
sudo dnf install ffmpeg
sudo dnf -y install ffmpeg-devel
sudo dnf -y install vlc

