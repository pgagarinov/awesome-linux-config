#!/bin/sh

set -e

# Graphviz (Graph visualization tool)
yay -S --noconfirm --needed graphviz

# DBearver db client
yay -S --noconfirm --needed dbeaver

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

#VLC media player
yay -S --needed --nocleanmenu  --nodiffmenu --noconfirm vlc

#KeePassXC password database
yay -S --needed --nocleanmenu  --nodiffmenu --noconfirm keepassxc

#Veyon classroom
#yay -S --needed --nocleanmenu  --nodiffmenu --noconfirm veyon
