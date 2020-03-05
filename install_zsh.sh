#!/bin/sh
set -e
sudo dnf install -y zsh
sudo chsh -s $(which zsh) $USER
echo '# default configuration'> ~/.zshrc
echo '# default configuraiton'> ~/.zprofile
