#!/bin/sh
set -e
sudo pacman -S --noconfirm wget curl tig htop mc nano screen ncdu vim nano-syntax-highlighting neofetch most
echo "include /usr/share/nano-syntax-highlighting/*.nanorc" >> ~/.nanorc
