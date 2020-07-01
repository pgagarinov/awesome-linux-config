#!/bin/sh
set -e
MSGCOLOR=`tput setaf 3`
NOCOLOR=`tput sgr0`

printf "${MSGCOLOR}Configuring Jupyter...${NOCOLOR}\n"
./config_jupyter.sh
printf "${MSGCOLOR}Configuring Jupyter: done${NOCOLOR}\n\n"

printf "${MSGCOLOR}Installing and configuring extras...${NOCOLOR}\n"
./install_extras_user.sh
printf "${MSGCOLOR}Installing and configuring extras: done${NOCOLOR}\n"

printf "${MSGCOLOR}Installing and configuring OhMyZsh...${NOCOLOR}\n"
./install_ohmyzsh.sh
printf "${MSGCOLOR}Installing and configuring OhMyZsh: done${NOCOLOR}\n"

printf "${MSGCOLOR}Configuring Powerlevel10k fonts...${NOCOLOR}\n"
./config_powerlevel10k_fonts.sh
printf "${MSGCOLOR}Configuring Powerlevel10k fonts: done${NOCOLOR}\n"

printf "${MSGCOLOR}Configuring Diff so Fancy...${NOCOLOR}\n"
./config_diff_so_fancy.sh
printf "${MSGCOLOR}Configuring Diff so Fancy: done${NOCOLOR}\n\n"
