#!/bin/sh
set -e
rm -f ./NVIDIA-Linux-x86_64-440.64.run
wget http://us.download.nvidia.com/XFree86/Linux-x86_64/440.64/NVIDIA-Linux-x86_64-440.64.run
sudo dnf groupinstall "Development Tools" -y
sudo dnf install libglvnd-devel elfutils-libelf-devel -y
sudo sh -c 'grub2-editenv - set "$(grub2-editenv - list | grep kernelopts) nouveau.modeset=0"'
sudo systemctl isolate multi-user.target
