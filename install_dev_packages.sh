#!/bin/sh
set -e
echo 'set bell-style none' >> ~/.inputrc
sudo yum install epel-release -y
sudo yum install wget -y
sudo yum install libzstd -y
sudo yum install git git-lfs tig htop mc nano screen ncdu tigervnc-server -y
#install git-lfs
#curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.rpm.sh | sudo bash
#sudo yum install git-lfs -y
#git lfs install
#sudo yum install make ncurses-devel ncurses -y
#sudo yum groupinstall 'Development Tools'
#https://github.com/jonas/tig/releases/download/tig-2.5.0/tig-2.5.0.tar.gz
#tar -xvf ./tig-2.5.0.tar.gz
#cd ./tig-2.5.0/
#make
#make install
# Doesn't yet work on CentOS 8
# sudo yum install sysbench go
# go get github.com/prasmussen/gdrive
# sysbench --test=cpu --cpu-max-prime=20000 run
