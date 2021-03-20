#!/bin/sh
set -e
MAIN_MSGCOLOR=`tput setaf 48`
MSGCOLOR=`tput setaf 3`
NOCOLOR=`tput sgr0`

full_path=$(realpath $0)
dir_path=$(dirname $full_path)

printf "${MAIN_MSGCOLOR}------Installing all system-wide packages...------${NOCOLOR}\n"

printf "${MSGCOLOR}Installing all server packages...${NOCOLOR}\n"
$dir_path/install_4server_all.sh
printf "${MSGCOLOR}Installing all server packages: done${NOCOLOR}\n\n"

printf "${MSGCOLOR}Installing MiniKube...${NOCOLOR}\n"
$dir_path/install_minikube.sh
printf "${MSGCOLOR}Installing MiniKube: done${NOCOLOR}\n"

printf "${MSGCOLOR}Installing and configuring Powerlevel10k fonts...${NOCOLOR}\n"
$dir_path/install_powerlevel10k_fonts.sh
printf "${MSGCOLOR}Installing and configuring Powerlevel10k fonts: done${NOCOLOR}\n"

printf "${MSGCOLOR}Installing and configuring extras...${NOCOLOR}\n"
$dir_path/install_extras.sh
printf "${MSGCOLOR}Installing and configuring extras: done${NOCOLOR}\n"

printf "${MSGCOLOR}Installing and configuring extras2...${NOCOLOR}\n"
$dir_path/install_extras2.sh
printf "${MSGCOLOR}Installing and configuring extras2: done${NOCOLOR}\n"

printf "${MAIN_MSGCOLOR}------Installing all system-wide packages: SUCCESS!------${NOCOLOR}\n"
