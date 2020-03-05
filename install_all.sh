#!/bin/sh
set -e
GREEN=`tput setaf 2`
NOCOLOR=`tput sgr0`
printf "${GREEN}Enabling sudo without password prompt...${NOCOLOR}\n"
./sudo_nopasswd.sh
printf "${GREEN}Enabling sudo without password prompt: done${NOCOLOR}\n\n"

printf "${GREEN}Installing dev packages...${NOCOLOR}\n"
./install_dev_packages.sh
printf "${GREEN}Installing dev packages: done${NOCOLOR}\n\n"

printf "${GREEN}Installing zsh...${NOCOLOR}\n"
./install_zsh.sh
printf "${GREEN}Installing zsh: done${NOCOLOR}\n\n"

printf "${GREEN}Installing and setting up git...${NOCOLOR}\n"
./install_setup_git.sh
printf "${GREEN}Installing and setting up git: done${NOCOLOR}\n\n"

printf "${GREEN}Installing and setting up miniconda...${NOCOLOR}\n"
./install_miniconda.sh
printf "${GREEN}Installing and setting up miniconda: done...${NOCOLOR}\n\n"


printf "${GREEN}Installing docker...${NOCOLOR}\n"
./install_docker.sh
printf "${GREEN}Installing docker: done${NOCOLOR}\n\n"


printf "${GREEN}Installing Rust cli utils...${NOCOLOR}\n"
./install_rust_utils.sh
printf "${GREEN}Installing Rust cli utils: done${NOCOLOR}\n\n"


printf "${GREEN}Installing and configuing OhMyZsh...${NOCOLOR}\n"
#./install_ohmyzsh.sh
printf "${GREEN}Installing and configuring OhMyZsh: done${NOCOLOR}\n"
