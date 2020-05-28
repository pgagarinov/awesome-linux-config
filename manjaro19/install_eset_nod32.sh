#!/bin/sh
set -e

printf 'Downloading ESET NOD32 Antivirus for Linux Desktop...\n' 
wget https://download.eset.com/com/eset/apps/home/eav/linux/latest/eset_nod32av_64bit_en.linux

printf 'Changing installer permissions...'
sudo chmod +x eset_nod32av_64bit_en.linux

printf 'Install dependencies...'
yay -S --noconfirm --needed lib32-gtk2 cpio

printf 'Opening the installer, please follow the graphical interface...'
./eset_nod32av_64bit_en.linux

printf 'Removing the installer...'
rm eset_nod32av_64bit_en.linux
