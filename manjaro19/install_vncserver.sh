#!/bin/sh
set -e
sudo pacman -S --noconfirm --needed tigervnc
./add_x0vncserver_service.sh
sudo loginctl enable-linger $USER
systemctl --user start x0vncserver.service
systemctl --user enable x0vncserver.service