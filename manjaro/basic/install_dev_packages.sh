#!/bin/sh
set -e
sudo pacman -S --noconfirm --needed base-devel
sudo pacman -S --noconfirm --needed htop neofetch most
sudo pacman -S --noconfirm --needed screen tmux
sudo pacman -S --noconfirm --needed nano vim nano-syntax-highlighting neovim
sudo pacman -S --noconfirm --needed mc ncdu
sudo pacman -S --noconfirm --needed wget curl bind-tools rsync w3m
sudo pacman -S --noconfirm --needed unzip p7zip
yay -S --noconfirm --needed --nocleanmenu --nodiffmenu neovim-plug
yay -S --noconfirm --needed libffi6 # for miniconda
