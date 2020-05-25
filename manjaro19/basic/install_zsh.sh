#!/bin/sh
set -e
sudo pacman -S --noconfirm --needed zsh
if id $USER@alliedtesting.com; 
then
    echo "Domain user!"
    sudo getent passwd $USER
else
    echo "Local user!"
    sudo chsh -s $(which zsh) $USER
fi
echo '# default configuration'> ~/.zshrc
echo '# default configuraiton'> ~/.zprofile
