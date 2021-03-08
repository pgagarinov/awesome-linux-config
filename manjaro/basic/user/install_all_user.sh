#!/bin/bash
set -e
MSGCOLOR=`tput setaf 3`
MAIN_MSGCOLOR=`tput setaf 50`
NOCOLOR=`tput sgr0`

full_path=$(realpath $0)
dir_path=$(dirname $full_path)

printf "${MAIN_MSGCOLOR}------Installing user-specific packages...------${NOCOLOR}\n"

printf "${MSGCOLOR}Installing server stuff...${NOCOLOR}\n"
$dir_path/install_server_stuff_user.sh
printf "${MSGCOLOR}Installing server stuff: done${NOCOLOR}\n"

printf "${MSGCOLOR}Configuring Powerlevel10k fonts...${NOCOLOR}\n"
$dir_path/config_powerlevel10k_fonts.sh
printf "${MSGCOLOR}Configuring Powerlevel10k fonts: done${NOCOLOR}\n"

printf "${MSGCOLOR}Installing and configuring extras2...${NOCOLOR}\n"
$dir_path/install_extras2_user.sh
printf "${MSGCOLOR}Installing and configuring extras2: done${NOCOLOR}\n"

printf "${MSGCOLOR}Installing and configuring Allure commandline...${NOCOLOR}\n"
$dir_path/install_allure_user.sh
printf "${MSGCOLOR}Installing and configuring Allure commandline: done${NOCOLOR}\n"

printf "${MSGCOLOR}Make IntelliJ2020.3 use JDK11${NOCOLOR}\n"
$dir_path/make_intellij2020_3_use_jdk11.sh
printf "${MSGCOLOR}Make IntelliJ2020.3 use JDK11: done${NOCOLOR}\n"

printf "${MSGCOLOR}Installing Rust toolchain components...${NOCOLOR}\n"
$dir_path//install_rust_toolchain.sh
printf "${MSGCOLOR}Installing Rust toolchain components: done${NOCOLOR}\n"

printf "${MSGCOLOR}Installing VSCode extensions...${NOCOLOR}\n"
$dir_path/install_vscode_extensions.sh
printf "${MSGCOLOR}Installing VSCode extensions: done${NOCOLOR}\n"

printf "${MSGCOLOR}Configure NeoVim...${NOCOLOR}\n"
$dir_path/config_neovim.sh
printf "${MSGCOLOR}Configure NeoVim: done${NOCOLOR}\n"

printf "${MAIN_MSGCOLOR}------Installing user-specific packages: COMPLETED SUCCESSFULLY!------${NOCOLOR}\n"

