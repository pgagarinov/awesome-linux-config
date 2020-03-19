#!/bin/sh
set -e
#rm -f ./NVIDIA-Linux-x86_64-440.64.run
rm -f ./NVIDIA-Linux-x86_64-435.21.run
#wget http://us.download.nvidia.com/XFree86/Linux-x86_64/440.64/NVIDIA-Linux-x86_64-440.64.run
wget http://us.download.nvidia.com/XFree86/Linux-x86_64/435.21/NVIDIA-Linux-x86_64-435.21.run
sudo dnf groupinstall "Development Tools" -y
sudo dnf install libglvnd-devel elfutils-libelf-devel -y

#sudo sh -c 'grub2-editenv - set "$(grub2-editenv - list | grep kernelopts) nouveau.modeset=0"'
# remove rhgb
#sudo sh -c 'grub2-editenv - set "kernelopts=root=/dev/mapper/cl-root ro crashkernel=auto resume=/dev/mapper/cl-swap rd.lvm.lv=cl/root rd.lvm.lv=cl/swap quiet  nouveau.modeset=0"'
sudo sh -c 'grub2-editenv - set "$(grub2-editenv - list | grep kernelopts|sed -e "'"s/\<rhgb\>//g"'"|sed -e "'"s/\<nouveau.modeset=0\>//g"'") nouveau.modeset=0"'



sudo systemctl isolate multi-user.target
