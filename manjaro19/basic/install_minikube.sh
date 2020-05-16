#!/bin/sh
set -e
sudo pacman -S --noconfirm minikube
sudo pacman -S --noconfirm kubectl

## Check that minikube works as expected

# first become another group, this is the same as 'newgrp docker' but inside the same shell
group=docker
if [ $(id -gn) != $group ]; then
 exec sg $group "$0 $*"
fi

minikube start
minikube stop

## type `minikube dashboard` or `minikube dashboard --url` to start Kubernetes dashboard
