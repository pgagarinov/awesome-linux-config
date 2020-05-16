#!/bin/bash
set -e

#make sure pamac-cli is installed

sudo pacman -S --noconfirm pamac-cli

#enable AUR in pamac
sudo sed --in-place "s/#EnableAUR/EnableAUR/" "/etc/pamac.conf"

# Install yay installer
sudo pacman -S --noconfirm yay
