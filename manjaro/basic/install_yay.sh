#!/bin/bash
set -e
#enable AUR in pamac
sudo sed --in-place "s/#EnableAUR/EnableAUR/" "/etc/pamac.conf" 

#Update system via Pacman
sudo pacman -Syyuu

# Install yay installer
sudo pacman -S --noconfirm --needed yay

#Updating yay packages
yay -Syyuu --nocleanmenu --nodiffmenu --noconfirm
