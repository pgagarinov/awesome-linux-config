#!/bin/sh
set -e
grep -qxF 'set bell-style none' ~/.inputrc || echo 'set bell-style none'>> ~/.inputrc

sudo yum install epel-release -y
sudo yum install wget curl -y
sudo yum install libzstd -y
sudo yum install tig htop mc nano screen ncdu tigervnc-server -y
sudo yum install zsh
sudo chsh -s $(which zsh) $USER
