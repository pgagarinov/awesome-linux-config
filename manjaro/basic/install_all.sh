#!/bin/sh
set -e
MSGCOLOR=`tput setaf 3`
NOCOLOR=`tput sgr0`

full_path=$(realpath $0)
dir_path=$(dirname $full_path)

printf "${MSGCOLOR}Installing server components...${NOCOLOR}\n"
$dir_path/install_server_stuff.sh
printf "${MSGCOLOR}Installing server components: done${NOCOLOR}\n\n"

printf "${MSGCOLOR}Installing and configuring Powerlevel10k fonts...${NOCOLOR}\n"
$dir_path/install_powerlevel10k_fonts.sh
printf "${MSGCOLOR}Installing and configuring Powerlevel10k fonts: done${NOCOLOR}\n"

printf "${MSGCOLOR}Installing and configuring extras...${NOCOLOR}\n"
$dir_path/install_extras.sh
printf "${MSGCOLOR}Installing and configuring extras: done${NOCOLOR}\n"

printf "${MSGCOLOR}Installing and configuring extras2...${NOCOLOR}\n"
$dir_path/install_extras2.sh
printf "${MSGCOLOR}Installing and configuring extras2: done${NOCOLOR}\n"
