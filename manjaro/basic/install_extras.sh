#!/bin/bash
set -e
#enable AUR in pamac
sudo sed --in-place "s/#EnableAUR/EnableAUR/" "/etc/pamac.conf" 

#Update system via Pacman
sudo pacman -Syyuu

# Install yay installer
sudo pacman -S --noconfirm --needed yay

#Updating yay packages
yay -Syyuu --nocleanmenu --nodiffmenu --noconfirm

# Install Brave Browser
sudo pacman -S --noconfirm --needed brave

# Install Zoom
yay -Sy --noconfirm zoom

# Install flatpak
sudo pacman -S --noconfirm --needed flatpak

# Install timeshift for local backups
sudo pacman -S --noconfirm --needed timeshift

# Bleachbit for cleaning the system
sudo pacman -S --noconfirm bleachbit

# Install Slack for Desktop
yay -S --noconfirm --needed slack-desktop

# Install FileZilla
sudo pacman -S --noconfirm --needed filezilla

# Install Skype
#yay -S --noconfirm --needed skype
yay -S --noconfirm --needed skypeforlinux-stable-bin

# Install PyCharm professional (should be the latest)
sudo pacman -S --noconfirm --needed xdg-utils
yay -S --noconfirm --needed pycharm-professional
#flatpak install -y --user flathub com.jetbrains.PyCharm-Professional

# Cool file manager
sudo pacman -S --noconfirm --needed krusader

# Cool Multi-window terminal
sudo pacman -S --noconfirm --needed terminator

# VSCode
sudo pacman -S --noconfirm --needed code

# Microsoft fonts 
yay -S --noconfirm --needed ttf-ms-fonts
yay -S --noconfirm --needed ttf-vista-fonts

# Install GIMP image editor
sudo pacman -S --noconfirm --needed gimp

# Virt viewer is SPICE client
# https://www.spice-space.org/spice-user-manual.html#spice-client
yay -S --noconfirm --needed virt-viewer

# Virt manager is UI app for managing KVM VMs
# https://wiki.manjaro.org/index.php?title=Virt-manager
sudo pacman -S --noconfirm --needed virt-manager qemu vde2 ebtables dnsmasq bridge-utils openbsd-netcat
sudo systemctl enable libvirtd.service
sudo systemctl start libvirtd.service
sudo usermod -aG libvirt $USER

#Install Intellij Ultimate
#flatpak install -y --user flathub com.jetbrains.IntelliJ-IDEA-Ultimate
yay -S --noconfirm --needed webstorm-jre #https://medium.com/@julianvargkim/how-to-fix-tried-to-user-preview-panel-provider-javafx-webview-error-on-linux-manjaro-ac5b6326ee1a
yay -S --noconfirm --needed intellij-idea-ultimate-edition

#Install DataGrip
#flatpak install -y --user flathub com.jetbrains.DataGrip
yay -S --noconfirm --needed datagrip


#Install Google Chrome
yay -S --noconfirm --needed google-chrome

#Install Chrome Driver for testing
yay -S --noconfirm --needed chromedriver

#Install Firefox driver 
#yay -S --noconfirm --needed geckodriver-hg
sudo pacman -S --noconfirm --needed geckodriver
