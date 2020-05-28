#!/bin/sh
set -e
sudo pacman -S --noconfirm --needed aws-cli
yay -S --noconfirm --needed aws-iam-authenticator-bin
