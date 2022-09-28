#!/bin/bash
set -e
sudo rm -rf /etc/pacman.d/gnupg
sudo pacman -Sc --noconfirm
sudo pacman-key --init
mkdir -pv $HOME/.cache/pkg/
printf "y\nn\nn" | sudo pacman -Syw archlinux-keyring manjaro-keyring --cachedir $HOME/.cache/pkg/ ||true
rm -f $HOME/.cache/pkg/*.sig
sudo pacman -U $HOME/.cache/pkg/*.tar.zst --noconfirm
#sudo pacman -U $HOME/.cache/pkg/*.tar.xz --noconfirm
sudo pacman -Sc --noconfirm
sudo rm -Rf $HOME/.cache/pkg/
