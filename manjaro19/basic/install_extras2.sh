#!/bin/sh

set -e

# Matrix-like terminal-based screen-saver	
sudo pacman -S --noconfirm cmatrix 

# Install goldendict	
sudo pacman -S goldendict

# Install Grub Customizer
sudo pacman -S --noconfirm grub-customizer

# Install wavemon	
sudo pacman -S --noconfirm wavemon	


# Install Vivaldi browser	
yay -Sy --noconfirm vivaldi	
sudo /opt/vivaldi/update-ffmpeg

# KeePassXC password manager
sudo pacman -S --noconfirm keepassxc
