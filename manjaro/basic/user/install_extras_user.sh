#!/bin/bash
set -e
# Install Viber only for a current user
flatpak remote-add --user flathub https://flathub.org/repo/flathub.flatpakrepo --if-not-exists
flatpak install -y --user flathub com.viber.Viber

# Libre Office
sudo pacman -S libreoffice-fresh --noconfirm

#Install EasySSH
flatpak install -y --user flathub com.github.muriloventuroso.easyssh
#yay -S --noconfirm --needed easyssh
