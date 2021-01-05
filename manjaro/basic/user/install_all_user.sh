#!/bin/bash
set -e
MSGCOLOR=`tput setaf 3`
NOCOLOR=`tput sgr0`

printf "${MSGCOLOR}Installing server stuff...${NOCOLOR}\n"
./install_server_stuff_user.sh
printf "${MSGCOLOR}Installing server stuff: done${NOCOLOR}\n"

printf "${MSGCOLOR}Configuring Powerlevel10k fonts...${NOCOLOR}\n"
./config_powerlevel10k_fonts.sh
printf "${MSGCOLOR}Configuring Powerlevel10k fonts: done${NOCOLOR}\n"

printf "${MSGCOLOR}Installing and configuring extras2...${NOCOLOR}\n"
./install_extras2_user.sh
printf "${MSGCOLOR}Installing and configuring extras2: done${NOCOLOR}\n"

printf "${MSGCOLOR}Installing and configuring Allure commandline...${NOCOLOR}\n"
./install_allure_user.sh
printf "${MSGCOLOR}Installing and configuring Allure commandline: done${NOCOLOR}\n"

printf "${MSGCOLOR}Make IntelliJ2020.3 use JDK11${NOCOLOR}\n"
./make_intellij2020_3_use_jdk11.sh
printf "${MSGCOLOR}Make IntelliJ2020.3 use JDK11: done${NOCOLOR}\n"

printf "${MSGCOLOR}INSTALLING ALL: COMPLETED SUCCESFULLY!!!${NOCOLOR}\n"
