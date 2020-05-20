#!/bin/sh
set -e
sudo pacman -S --noconfirm base-devel
sudo pacman -S --noconfirm htop neofetch most
sudo pacman -S --noconfirm screen
sudo pacman -S --noconfirm nano vim nano-syntax-highlighting
sudo pacman -S --noconfirm mc ncdu
sudo pacman -S --noconfirm wget curl bind-tools rsync
echo "include /usr/share/nano-syntax-highlighting/*.nanorc" >> ~/.nanorc
