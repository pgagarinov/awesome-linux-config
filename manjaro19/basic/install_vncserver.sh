#!/bin/sh
set -e
sudo pacman -S --noconfirm --needed tigervnc
vncpasswd
cat << "EOF" >> ~/.xprofile
x0vncserver -rfbauth ~/.vnc/passwd &
EOF