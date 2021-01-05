#!/bin/bash
set -e
MSGCOLOR=`tput setaf 3`
NOCOLOR=`tput sgr0`

printf "${MSGCOLOR}Configuring Jupyter...${NOCOLOR}\n"
./config_jupyter.sh
printf "${MSGCOLOR}Configuring Jupyter: done${NOCOLOR}\n\n"

printf "${MSGCOLOR}Installing and configuring OhMyZsh...${NOCOLOR}\n"
./install_ohmyzsh.sh
printf "${MSGCOLOR}Installing and configuring OhMyZsh: done${NOCOLOR}\n"

printf "${MSGCOLOR}Configuring Diff so Fancy...${NOCOLOR}\n"
./config_diff_so_fancy.sh
printf "${MSGCOLOR}Configuring Diff so Fancy: done${NOCOLOR}\n\n"

printf "${MSGCOLOR}Installing and configuring git...${NOCOLOR}\n"
./config_git.sh
printf "${MSGCOLOR}Installing and configuring git: done${NOCOLOR}\n"

printf "${MSGCOLOR}INSTALLING SERVER STUFF: COMPLETED SUCCESSFULLY!!!${NOCOLOR}\n"
