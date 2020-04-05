# Enable community package sources
1. In /etc/apt/sources.list  add

`deb http://download.proxmox.com/debian/pve buster pve-no-subscription`

2. Comment out enterprise source in 
/etc/apt/sources.list.d/pve-enterprise.list
