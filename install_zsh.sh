#!/bin/sh
set -e
sudo yum install zsh
sudo chsh -s $(which zsh) $USER
