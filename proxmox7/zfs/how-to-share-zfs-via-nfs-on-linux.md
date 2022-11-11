
# References

1. https://www.ctfnote.com/red-teaming/privilege-escalation/linux-privilege-escalation/nfs-root-squashing
2. https://forum.proxmox.com/threads/getting-permission-denied-on-zfs-shares-after-upgrade-to-proxmox-6-1-from-5-4.65841/
3. https://blog.programster.org/sharing-zfs-datasets-via-nfs

# Long story short:
## On the server (Debian, Proxmox)
Run
1. `apt install -y nfs-kernel-server`
2. `zfs create xpool/nfs-storage`
3. `zfs set sharenfs="async,rw=@10.115.177.0/24,no_root_squash" xpool/nfs-storage` # async is very important for getting a decent speed
