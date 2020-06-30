#!/bin/sh
set -e

if id | grep $USER; 
then
    echo "Domain user!"
    sudo getent passwd $USER
else
    echo "Local user!"
    sudo chsh -s $(which zsh) $USER
fi
echo '# default configuration'> ~/.zshrc
echo '# default configuraiton'> ~/.zprofile
