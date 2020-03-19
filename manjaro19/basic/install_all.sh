#!/bin/sh
set -e
MSGCOLOR=`tput setaf 3`
NOCOLOR=`tput sgr0`
printf "${MSGCOLOR}Enabling sudo without password prompt...${NOCOLOR}\n"
./sudo_nopasswd.sh
printf "${MSGCOLOR}Enabling sudo without password prompt: done${NOCOLOR}\n\n"

printf "${MSGCOLOR}Selecting fastest mirrors and updating packages...${NOCOLOR}\n"
./select_mirrors_and_update.sh
printf "${MSGCOLOR}Selecting fastest mirrors and updating packages: done${NOCOLOR}\n"

printf "${MSGCOLOR}Installing dev packages...${NOCOLOR}\n"
./install_dev_packages.sh
printf "${MSGCOLOR}Installing dev packages: done${NOCOLOR}\n\n"

printf "${MSGCOLOR}Setting up XRDP...${NOCOLOR}\n"
./install_rdp_server.sh
printf "${MSGCOLOR}Setting up XRDP: done${NOCOLOR}\n\n"


printf "${MSGCOLOR}Installing zsh...${NOCOLOR}\n"
./install_zsh.sh
printf "${MSGCOLOR}Installing zsh: done${NOCOLOR}\n\n"


printf "${MSGCOLOR}Installing AWS CLI...${NOCOLOR}\n"
./install_aws.sh
printf "${MSGCOLOR}Installing AWS CLI: done${NOCOLOR}\n\n"


printf "${MSGCOLOR}Installing and setting up git...${NOCOLOR}\n"
./install_setup_git.sh
printf "${MSGCOLOR}Installing and setting up git: done${NOCOLOR}\n\n"

printf "${MSGCOLOR}Installing and setting up miniconda...${NOCOLOR}\n"
./install_miniconda.sh
printf "${MSGCOLOR}Installing and setting up miniconda: done...${NOCOLOR}\n\n"

printf "${MSGCOLOR}Configuring Jupyter...${NOCOLOR}\n"
./config_jupyter.sh
printf "${MSGCOLOR}Configuring Jupyter: done${NOCOLOR}\n\n"

printf "${MSGCOLOR}Installing docker...${NOCOLOR}\n"
./install_docker.sh
printf "${MSGCOLOR}Installing docker: done${NOCOLOR}\n\n"


printf "${MSGCOLOR}Installing Rust cli utils...${NOCOLOR}\n"
./install_rust_utils.sh
printf "${MSGCOLOR}Installing Rust cli utils: done${NOCOLOR}\n\n"


printf "${MSGCOLOR}Installing and configuing OhMyZsh...${NOCOLOR}\n"
./install_ohmyzsh.sh
printf "${MSGCOLOR}Installing and configuring OhMyZsh: done${NOCOLOR}\n"

printf "${MSGCOLOR}Installing and configuing OhMyZsh...${NOCOLOR}\n"
./install_powerlevel10k_fonts.sh
printf "${MSGCOLOR}Installing and configuring OhMyZsh: done${NOCOLOR}\n"
