# Setting up NFS share on ZFS

## Explanation
ZFS has a built-in command for creating an NFS share without actually
having to configure NFS shares directly. Along NFS it is also possible
to create CIFS shares via one-liner as well.


## Assumptions:
 - Debian/Proxmox
 - Already configured ZFS pool 

## How to set it up

1. `apt install -y nfs-kernel-server`
2. `zfs create xpool/nfs-storage`
3. `zfs set sharenfs="async,rw=@10.115.177.0/24,no_root_squash" xpool/nfs-storage` 

Please mind `async` which is very important for getting a decent write speed.
This mode allows NFS not to wait till confirmation from ZFS that the
write on the disk is completed. As an alternative to enabling `async`
mode for NFS you can set `sync=disabled` for the shared ZFS dataset:
```
zfs set sync=disabled xpool/nfs-storage
```
The positive performance impact of this is similar to `async`. Enabling
both `async` for NFS and `sync=disabled` for ZFS does not provide any
additional performance improvements.

## References

1. https://www.ctfnote.com/red-teaming/privilege-escalation/linux-privilege-escalation/nfs-root-squashing
2. https://forum.proxmox.com/threads/getting-permission-denied-on-zfs-shares-after-upgrade-to-proxmox-6-1-from-5-4.65841/
3. https://blog.programster.org/sharing-zfs-datasets-via-nfs

