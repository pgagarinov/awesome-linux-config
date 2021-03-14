#!/bin/sh
set -e

MSGCOLOR=`tput setaf 3`
NOCOLOR=`tput sgr0`
MAIN_MSGCOLOR=`tput setaf 49`

full_path=$(realpath $0)
dir_path=$(dirname $full_path)


printf "${MAIN_MSGCOLOR}---Installing server-oriented system-wide dependencies...---${NOCOLOR}\n"
printf "${MSGCOLOR}Enabling sudo without password prompt...${NOCOLOR}\n"
$dir_path/sudo_nopasswd.sh
printf "${MSGCOLOR}Enabling sudo without password prompt: done${NOCOLOR}\n\n"

printf "${MSGCOLOR}Removing Canonical stuff...${NOCOLOR}\n"
$dir_path/remove_canonical_stuff.sh
printf "${MSGCOLOR}Removing Canonical stuff: done${NOCOLOR}\n\n"

#printf "${MSGCOLOR}Selecting fastest mirrors and updating packages...${NOCOLOR}\n"
#./select_mirrors_and_update.sh
#printf "${MSGCOLOR}Selecting fastest mirrors and updating packages: done${NOCOLOR}\n"

printf "${MSGCOLOR}Updating packages...${NOCOLOR}\n"
$dir_path/update_all_via_pacman_or_yay.sh
printf "${MSGCOLOR}Updating packages: done${NOCOLOR}\n"

printf "${MSGCOLOR}Enabling AURs...${NOCOLOR}\n"
$dir_path/enable_aurs.sh
printf "${MSGCOLOR}Enabling AURs: done${NOCOLOR}\n"

printf "${MSGCOLOR}Installing dev packages...${NOCOLOR}\n"
$dir_path/install_dev_packages.sh
printf "${MSGCOLOR}Installing dev packages: done${NOCOLOR}\n\n"

printf "${MSGCOLOR}Installing NodeJS...${NOCOLOR}\n"
$dir_path/install_nodejs.sh
printf "${MSGCOLOR}Installing NodeJS: done${NOCOLOR}\n\n"

printf "${MSGCOLOR}Installing JDK8 and Maven...${NOCOLOR}\n"
$dir_path/install_jdk8_maven.sh
printf "${MSGCOLOR}Installing JDK8 and Maven: done${NOCOLOR}\n\n"

printf "${MSGCOLOR}Installing JDK11 ...${NOCOLOR}\n"
$dir_path/install_jdk11.sh
printf "${MSGCOLOR}Installing JDK11: done${NOCOLOR}\n"

printf "${MSGCOLOR}Installing zsh...${NOCOLOR}\n"
$dir_path/install_zsh.sh
printf "${MSGCOLOR}Installing zsh: done${NOCOLOR}\n\n"

printf "${MSGCOLOR}Installing AWS CLI...${NOCOLOR}\n"
$dir_path/install_aws.sh
printf "${MSGCOLOR}Installing AWS CLI: done${NOCOLOR}\n\n"

printf "${MSGCOLOR}Installing and setting up git...${NOCOLOR}\n"
$dir_path/install_setup_git.sh
printf "${MSGCOLOR}Installing and setting up git: done${NOCOLOR}\n\n"

printf "${MSGCOLOR}Installing and setting up miniconda...${NOCOLOR}\n"
$dir_path/install_miniconda.sh
printf "${MSGCOLOR}Installing and setting up miniconda: done...${NOCOLOR}\n\n"

printf "${MSGCOLOR}Installing docker...${NOCOLOR}\n"
$dir_path/install_docker.sh
printf "${MSGCOLOR}Installing docker: done${NOCOLOR}\n\n"

printf "${MSGCOLOR}Installing docker-compose...${NOCOLOR}\n"
$dir_path/install_docker_compose.sh
printf "${MSGCOLOR}Installing docker-compose: done${NOCOLOR}\n\n"

printf "${MSGCOLOR}Installing Rust cli utils...${NOCOLOR}\n"
$dir_path/install_rust_utils.sh
printf "${MSGCOLOR}Installing Rust cli utils: done${NOCOLOR}\n\n"

printf "${MSGCOLOR}Updating packages one more time...${NOCOLOR}\n"
$dir_path/update_all_via_pacman_or_yay.sh
printf "${MSGCOLOR}Updating packages one more time: done${NOCOLOR}\n"

printf "${MSGCOLOR}Installing extras for server...${NOCOLOR}\n"
$dir_path/install_server_extras.sh
printf "${MSGCOLOR}Installing extras for server: done${NOCOLOR}\n"

printf "${MSGCOLOR}Installing Julia...${NOCOLOR}\n"
$dir_path/install_julia.sh
printf "${MSGCOLOR}Installing Julia: done${NOCOLOR}\n"
printf "${MAIN_MSGCOLOR}---Installing server-oriented system-wide dependencies: SUCCESS!---${NOCOLOR}\n"
