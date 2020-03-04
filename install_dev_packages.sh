#!/bin/sh
set -e
echo 'set bell-style none' >> ~/.inputrc
sudo yum install epel-release -y
sudo yum install wget curl -y
sudo yum install libzstd -y
sudo yum install tig htop mc nano screen ncdu tigervnc-server -y
