# Problem
OpenVPN client doesn't react to DNS push from the server

# Solution
Follow https://wiki.archlinux.org/title/OpenVPN#The_update-resolv-conf_custom_script

- make sure /resolv.conf contains a single name server
- make sure it has an immutable flag via `sudo chattr -i /etc/resolv.conf`
- install openvpn-update-resolv-conf via `yay -S openvpn-update-resolv-conf` (also installs openresolv as a dependency)
- do not use NetworkManager for establishing OpenVPN connection, use `sudo openvpn <your-vpn-config.conf` instead
- use `resolvconf -l` to check current DNS override made by openresolv