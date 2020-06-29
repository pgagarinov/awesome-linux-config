#!/bin/sh
set -e
MSGCOLOR=`tput setaf 3`
NOCOLOR=`tput sgr0`
printf "${MSGCOLOR}Enabling sudo without password prompt...${NOCOLOR}\n"	
./sudo_nopasswd.sh	
printf "${MSGCOLOR}Enabling sudo without password prompt: done${NOCOLOR}\n\n"

printf "${MSGCOLOR}Removing Canonical stuff...${NOCOLOR}\n"
./remove_canonical_stuff.sh
printf "${MSGCOLOR}Removing Canonical stuff: done${NOCOLOR}\n\n"

printf "${MSGCOLOR}Selecting fastest mirrors and updating packages...${NOCOLOR}\n"
./select_mirrors_and_update.sh
printf "${MSGCOLOR}Selecting fastest mirrors and updating packages: done${NOCOLOR}\n"

printf "${MSGCOLOR}Installing dev packages...${NOCOLOR}\n"
./install_dev_packages.sh
printf "${MSGCOLOR}Installing dev packages: done${NOCOLOR}\n\n"

printf "${MSGCOLOR}Enabling AURs...${NOCOLOR}\n"
./enable_aurs.sh
printf "${MSGCOLOR}Enabling AURs: done${NOCOLOR}\n"

printf "${MSGCOLOR}Installing NodeJS...${NOCOLOR}\n"
./install_nodejs.sh
printf "${MSGCOLOR}Installing NodeJS: done${NOCOLOR}\n\n"

printf "${MSGCOLOR}Installing JDK8 and Maven...${NOCOLOR}\n"
./install_jdk8_maven.sh
printf "${MSGCOLOR}Installing JDK8 and Maven: done${NOCOLOR}\n\n"

printf "${MSGCOLOR}Setting up RDP...${NOCOLOR}\n"
./install_rdp.sh
printf "${MSGCOLOR}Setting up RDP: done${NOCOLOR}\n\n"


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

printf "${MSGCOLOR}Installing docker...${NOCOLOR}\n"
./install_docker.sh
printf "${MSGCOLOR}Installing docker: done${NOCOLOR}\n\n"

printf "${MSGCOLOR}Installing docker-compose...${NOCOLOR}\n"
./install_docker_compose.sh
printf "${MSGCOLOR}Installing docker-compose: done${NOCOLOR}\n\n"

printf "${MSGCOLOR}Installing and configuring Powerlevel10k fonts...${NOCOLOR}\n"
./install_powerlevel10k_fonts.sh
printf "${MSGCOLOR}Installing and configuring Powerlevel10k fonts: done${NOCOLOR}\n"

printf "${MSGCOLOR}Installing and configuring extras...${NOCOLOR}\n"
./install_extras.sh
printf "${MSGCOLOR}Installing and configuring extras: done${NOCOLOR}\n"

printf "${MSGCOLOR}Installing spellchecking...${NOCOLOR}\n"
./install_spellchecking.sh
printf "${MSGCOLOR}Installing spellchecking: done${NOCOLOR}\n"

printf "${MSGCOLOR}Installing MiniKube...${NOCOLOR}\n"
./install_minikube.sh
printf "${MSGCOLOR}Installing MiniKube: done${NOCOLOR}\n"

printf "${MSGCOLOR}Installing and configuring extras2...${NOCOLOR}\n"
./install_extras2.sh
printf "${MSGCOLOR}Installing and configuring extras2: done${NOCOLOR}\n"
