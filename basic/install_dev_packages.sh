#!/bin/sh
set -e
grep -qxF 'set bell-style none' ~/.inputrc || echo 'set bell-style none'>> ~/.inputrc

sudo dnf update -y
sudo dnf install epel-release -y
sudo dnf update -y
sudo yum module enable perl:5.26 -y
sudo dnf install wget curl -y
sudo dnf install libzstd -y
sudo dnf install tig htop mc nano screen ncdu tigervnc-server -y
sudo dnf install transmission -y
