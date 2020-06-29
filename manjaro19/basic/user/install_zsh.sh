#!/bin/sh
set -e
sudo pacman -S --noconfirm --needed zsh

sudo chsh -s $(which zsh) $USER

echo '# default configuration'> ~/.zshrc
echo '# default configuraiton'> ~/.zprofile
