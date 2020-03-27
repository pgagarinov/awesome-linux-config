#!/bin/bash
set -e
# We do not want Canonical stuff)
sudo systemctl stop snapd.socket
sudo systemctl disable snapd.socket
sudo pacman -Rnsc --noconfirm snapd
