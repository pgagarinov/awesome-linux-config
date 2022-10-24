
# References

1. https://www.ctfnote.com/red-teaming/privilege-escalation/linux-privilege-escalation/nfs-root-squashing
2. https://forum.proxmox.com/threads/getting-permission-denied-on-zfs-shares-after-upgrade-to-proxmox-6-1-from-5-4.65841/
3. https://blog.programster.org/sharing-zfs-datasets-via-nfs

# Long story short:
## On the server (Debian, Proxmox)
sudo apt install -y nfs-kernel-server
zfs create xpool/nfs-storage
zfs set sharenfs="rw=@10.115.177.0/24,no_root_squash" xpool/nfs-storage
