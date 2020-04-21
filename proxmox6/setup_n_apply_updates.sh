#!/bin/bash
set -e
sed -i "s/deb/#deb/" /etc/apt/sources.list.d/pve-enterprise.list
grep -q "pve-no-subscription" /etc/apt/sources.list|| echo "deb http://download.proxmox.com/debian/pve buster pve-no-subscription" >> /etc/apt/sources.list
apt update
apt full-upgrade -y
pveam update
#sed -i.bak "s/data.status !== 'Active'/false/g" /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js && systemctl restart pveproxy.service
