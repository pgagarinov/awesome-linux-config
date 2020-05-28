#!/bin/sh
set -e
yay -S --noconfirm --needed libffi6
sudo rm -rf /opt/miniconda
sudo rm -rf ~/.conda
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
id -u miniconda &>/dev/null||sudo useradd miniconda

sudo sh ./Miniconda3-latest-Linux-x86_64.sh -b -p /opt/miniconda
sudo usermod -d /opt/miniconda miniconda
rm -rf ./Miniconda3-latest-Linux-x86_64.sh*
sudo chown -R miniconda:miniconda /opt/miniconda
sudo chmod -R go-w /opt/miniconda 
sudo chmod -R go+rX /opt/miniconda 

