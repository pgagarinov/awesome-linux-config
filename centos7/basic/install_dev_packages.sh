#!/bin/sh
set -e
grep -qxF 'set bell-style none' ~/.inputrc || echo 'set bell-style none'>> ~/.inputrc
#
sudo yum update -y
sudo yum install epel-release -y
sudo yum update -y
#
sudo yum group install "Development Tools" -y
#
# sudo yum module enable perl:5.26 -y
sudo yum install wget curl rsync -y
sudo yum install util-linux -y
sudo yum install libzstd -y
sudo yum install tig htop mc nano vim screen ncdu tigervnc-server tmux -y
sudo yum install transmission telnet -y
sudo yum install python3 python2 -y
sudo yum install java-1.8.0-openjdk-devel maven -y
sudo alternatives --set python /usr/bin/python3

#
# for man pages to look nicer
# this package is not yet available in CentOS 8 but can be installed on CentOS 7 via yum
# sudo yum install most -y
