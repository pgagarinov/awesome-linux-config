#!/bin/sh
set -e

sudo pacman -S --noconfirm pacman-mirrors 
sudo pacman-mirrors --geoip


