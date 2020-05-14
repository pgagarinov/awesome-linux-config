#!/bin/sh
set -e
sudo yum install yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install -y docker-ce

if [ -x "$(command -v firewall-cmd)" ];
then
  sudo systemctl disable firewalld
  sudo systemctl stop firewalld
fi
sudo systemctl enable --now docker
sudo usermod -aG docker $USER
#/usr/bin/newgrp docker <<EONG
#docker run hello-world
#EONG

# first become another group, this is the same as 'newgrp docker' but inside the same shell
group=docker
if [ $(id -gn) != $group ]; then
  exec sg $group "$0 $*"
fi
# then run 'hello-world' from under docker group (just to make sure docker is installed correctly)
docker run hello-world

