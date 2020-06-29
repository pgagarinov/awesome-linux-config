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

printf "${MSGCOLOR}Installing Rust cli utils...${NOCOLOR}\n"
./install_rust_utils.sh
printf "${MSGCOLOR}Installing Rust cli utils: done${NOCOLOR}\n\n"

printf "${MSGCOLOR}Installing zsh...${NOCOLOR}\n"
./install_zsh.sh
printf "${MSGCOLOR}Installing zsh: done${NOCOLOR}\n\n"

printf "${MSGCOLOR}Installing and configuring OhMyZsh...${NOCOLOR}\n"
./install_ohmyzsh.sh
printf "${MSGCOLOR}Installing and configuring OhMyZsh: done${NOCOLOR}\n"
