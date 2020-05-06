#!/bin/bash
set -e
if command -v snap;
then
	# We do not want Canonical stuff)
	sudo systemctl stop snapd.socket
	sudo systemctl disable snapd.socket
	sudo pacman -Rns --noconfirm snapd
else
	printf "${MSGCOLOR}Canonical stuff allready removed${NOCOLOR}\n"
fi
