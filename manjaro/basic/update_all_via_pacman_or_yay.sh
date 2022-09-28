#!/bin/bash
set -e

MSGCOLOR=`tput setaf 4`
NOCOLOR=`tput sgr0`


sudo pacman -S --noconfirm pacman-mirrors 
sudo pacman-mirrors --country Germany

if ! [ -x "$(command -v yay)" ]; then
  printf "${MSGCOLOR}Updating via pacman...${NOCOLOR}\n"
  sudo pacman -Syyuu --noconfirm --needed
  printf "${MSGCOLOR}Updating via pacman: done${NOCOLOR}\n"
else
  printf "${MSGCOLOR}Updating via yay...${NOCOLOR}\n"
  yay -Syyuu --nocleanmenu --nodiffmenu --noconfirm --needed
  printf "${MSGCOLOR}Updating via yay: done${NOCOLOR}\n"
fi

