#!/bin/bash
set -e

#make sure pamac-cli is installed

# Pure Arch system doesn't have pamac-cli package in the official repo
if uname -r | grep 'MANJARO' > /dev/null; then
  # Install yay installer
  sudo pacman -S --noconfirm yay
else
 rm -rf ./yay-git
 git clone https://aur.archlinux.org/yay-git.git
 cd ./yay-git
 makepkg -si --noconfirm
 cd ..
 rm -rf ./yay-git
fi

yay -S --noconfirm pamac-cli
#enable AUR in pamac
sudo sed --in-place "s/#EnableAUR/EnableAUR/" "/etc/pamac.conf"

