#!/bin/sh
set -e
sudo pacman -S --noconfirm --needed docker
sudo systemctl start docker
sudo systemctl enable --now docker
sudo usermod -aG docker $USER

# first become another group, this is the same as 'newgrp docker' but inside the same shell
group=docker
if [ $(id -gn) != $group ]; then
 exec sg $group "$0 $*"
fi
sudo sh -c 'echo "{ "features" : { "buildkit": true} }" > /etc/docker/daemon.json'
