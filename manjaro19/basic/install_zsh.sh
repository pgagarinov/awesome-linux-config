#!/bin/sh
set -e
sudo pacman -S --noconfirm --needed zsh

if id | grep $USER; 
then
    echo "Domain user!"
    sudo getent passwd $USER
else
    echo "Local user!"
    sudo chsh -s $(which zsh) $USER
fi
>>>>>>> separed the configs in different place:manjaro19/basic/install_zsh.sh
echo '# default configuration'> ~/.zshrc
echo '# default configuraiton'> ~/.zprofile
