# Enable automatic zfs snapshots by  
##1. Installzing zfs-auto-snapshot
via yay -S zfs-auto-snapshot

##2. Setting up the cronjob by creating
/etc/cron.d/zfs-auto-snapshot

with the following content

```
PATH="/usr/bin:/bin:/usr/sbin:/sbin"

*/5 * * * * root /sbin/zfs-auto-snapshot -q -g --label=frequent --keep=24 //
00 * * * * root /sbin/zfs-auto-snapshot -q -g --label=hourly --keep=24 //
59 23 * * * root /sbin/zfs-auto-snapshot -q -g --label=daily --keep=14 //
59 23 * * 0 root /sbin/zfs-auto-snapshot -q -g --label=weekly --keep=4 //
00 00 1 * * root /sbin/zfs-auto-snapshot -q -g --label=monthly --keep=18 //
```

## References
https://wiki.archlinux.org/index.php/ZFS#Automatic_snapshots
https://serverfault.com/questions/855895/how-to-set-the-number-of-snapshots-zfs-auto-snapshot-should-retain
https://github.com/zfsonlinux/zfs-auto-snapshot

