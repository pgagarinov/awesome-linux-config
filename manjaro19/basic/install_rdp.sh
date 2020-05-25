#!/bin/sh
set -e
#https://forum.manjaro.org/t/manjaro-kde-running-as-a-rdp-server/114561/14
#
#To access your Manjaro KDE (KDE 5, Plasma 5) remotely (thanks to @AJSlye ) via Remote Desktop Protocol (RDP) install FreeRDP ( http://www.freerdp.com/ 3 )...
#NOTE: FreeRDP is a free implementation of the Micro$$oft's RDP - Remote Desktop Protocol.
#
# pacman -S --noconfirm freerdp
#     After installing FreeRDP open a terminal and run (on your server) the 
# freerdp-shadow-cli 
#    command with the user you want to use to log in remotely...
sudo pacman -S --noconfirm --needed remmina freerdp mbedtls libvncserver spice-gtk
