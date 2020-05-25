#!/bin/sh
set -e
sudo pacman -S --noconfirm --needed aws-cli
yay -S --noconfirm aws-iam-authenticator-bin
