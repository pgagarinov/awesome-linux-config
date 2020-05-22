#!/bin/sh
set -e
sudo pacman -S --noconfirm aws-cli
sudo yay -S --noconfirm aws-iam-authenticator-bin
