#!/bin/sh
set -e
sudo pacman -S --noconfirm docker
sudo systemctl start docker
sudo systemctl enable --now docker
sudo usermod -aG docker $USER
