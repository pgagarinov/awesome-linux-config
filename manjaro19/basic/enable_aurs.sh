#!/bin/bash
set -e

#enable AUR in pamac
sudo sed --in-place "s/#EnableAUR/EnableAUR/" "/etc/pamac.conf"

# Install yay installer
sudo pacman -S --noconfirm yay
