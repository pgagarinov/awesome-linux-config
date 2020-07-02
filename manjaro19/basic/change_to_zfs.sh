#!/bin/sh
set -e

if id $USER@$(dnsdomainname); 
then
    echo "Domain user!"
    sudo getent passwd $USER
else
    echo "Local user!"
    sudo chsh -s $(which zsh) $USER
fi
