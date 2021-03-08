#!/bin/zsh
set -e

# we do not plan to use Windows so we decide to track execute bits to avoid calling
# git update-index --chmod=+x ./file.sh everytime we need to track x bit
git config --global core.fileMode true
git config --global core.editor "nvim"
#we do not want to set this globally, use it only for specific repos with some code committed on Windows
# git config --global core.autocrlf true
