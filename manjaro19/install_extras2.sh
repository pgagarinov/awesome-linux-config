#!/bin/sh

set -e

# Matrix-like terminal-based screen-saver
sudo pacman -S --noconfirm --needed cmatrix

# Install goldendict
sudo pacman -S --noconfirm --needed goldendict

# Install Grub Customizer
sudo pacman -S --noconfirm --needed grub-customizer

# Install wavemon
sudo pacman -S --noconfirm --needed wavemon


# Install Vivaldi browser
#yay -Sy --noconfirm vivaldi
#sudo /opt/vivaldi/update-ffmpeg

# KeePassXC password manager
sudo pacman -S --noconfirm --needed keepassxc

# qTox
yay -S --noconfirm --needed qtox
