#!/bin/sh
set -e
sudo pacman -S --noconfirm --needed kubectl
yay -S --noconfirm --needed krew-bin
yay -S --noconfirm --needed rancher-k3d-bin
yay -S --noconfirm --needed k9s
yay -S --noconfirm --needed devspace-bin vcluster
kubectl krew install ns ctx
## Check that minikube works as expected

# first become another group, this is the same as 'newgrp docker' but inside the same shell
group=docker
if [[ $(id -gn) != $group ]]; then
 exec sg $group "$0 $*"
fi
