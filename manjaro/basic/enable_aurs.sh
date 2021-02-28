#!/bin/bash
set -e

#make sure pamac-cli is installed

# Pure Arch system doesn't have pamac-cli package in the official repo
if uname -r | grep 'MANJARO' > /dev/null; then
  # Install yay installer
  sudo pacman -S --noconfirm --needed yay
else
 rm -rf ./yay-bin
 git clone https://aur.archlinux.org/yay-bin.git
 cd ./yay-bin
 makepkg -si --noconfirm
 cd ..
 rm -rf ./yay-bin
fi

yay -S --noconfirm --needed pamac-cli
#enable AUR in pamac
sudo sed --in-place "s/#EnableAUR/EnableAUR/" "/etc/pamac.conf"

#this is required for https://wiki.archlinux.org/index.php/Makepkg#Utilizing_multiple_cores_on_compression
yay -S pigz pbzip2 --noconfirm --needed


