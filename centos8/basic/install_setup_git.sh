#!/bin/sh
set -e
sudo dnf install -y git git-lfs
#git config --global user.name "Your Name"
#git config --global user.email "your@email"

# https://stackoverflow.com/questions/1580596/how-do-i-make-git-ignore-file-mode-chmod-changes
# https://medium.com/@tahteche/how-git-treats-changes-in-file-permissions-f71874ca239d

# we do not plan to use Windows so we decide to track execute bits to avoid calling 
# git update-index --chmod=+x ./file.sh everytime we need to track x bit
git config --global core.fileMode true
