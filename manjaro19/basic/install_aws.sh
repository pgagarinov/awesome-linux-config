#!/bin/sh
set -e
sudo pacman -S --noconfirm aws-cli
yay -S --noconfirm aws-iam-authenticator-bin
