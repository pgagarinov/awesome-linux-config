#!/bin/sh
set -e
sudo dnf install flatpak -y
flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install --user flathub org.freedesktop.Platform//19.08 -y
flatpak install --user flathub org.remmina.Remmina -y
