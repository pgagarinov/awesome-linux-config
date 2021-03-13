#!/bin/sh

set -e

# DBearver db client
yay -S --noconfirm --needed dbeaver

# pgAdming db client for PostgreSQL
yay -S pgadmin4 --noconfirm --needed

# Stack Haskell platform (dependency for ERD)
yay -S --noconfirm --needed stack

# Graphviz (Graph visualization tool)
yay -S --noconfirm --needed graphviz

# Screen capturing software
yay -S --noconfirm --needed obs-studio

# Video editing software
yay -S --noconfirm --needed kdenlive

# Diagramming Tool and Screenshot tool
yay -S --needed --nocleanmenu  --nodiffmenu --noconfirm drawio-desktop-bin flameshot

# Github-Desktop
yay -S --needed --nocleanmenu  --nodiffmenu --noconfirm github-desktop-bin

# Git-filter-repo
yay -S --needed --nocleanmenu --nodiffmenu --noconfirm git-filter-repo

# FAR for Linux
yay -S --needed --nocleanmenu  --nodiffmenu --noconfirm far2l-git

#VLC media player
yay -S --needed --nocleanmenu  --nodiffmenu --noconfirm vlc

#KeePassXC password database
yay -S --needed --nocleanmenu  --nodiffmenu --noconfirm keepassxc

#Veyon classroom
#yay -S --needed --nocleanmenu  --nodiffmenu --noconfirm veyon
