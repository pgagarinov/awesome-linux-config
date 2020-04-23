https://pve.proxmox.com/wiki/Migration_of_servers_to_Proxmox_VE#Clonezilla_Live_CDs
https://forum.proxmox.com/threads/hyper-v-gen-2-windows-guest-conversion.38954/
https://docs.fedoraproject.org/en-US/quick-docs/creating-windows-virtual-machines-using-virtio-drivers/index.html
https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/stable-virtio/virtio-win.iso


# 1. Create a target Machine with 
- IDE disk with writeback cache enabled
- QEMU agent activated
# 2. Copy the data on disk into the target Proxmox machine
- If source machine is Physical - use clonezilla to copy disk, see https://pve.proxmox.com/wiki/Migration_of_servers_to_Proxmox_VE#Clonezilla_Live_CDs
- If source is Hyper-V VM - use Qemu convertor, see  https://pve.proxmox.com/wiki/Migration_of_servers_to_Proxmox_VE#HyperV
# 3. Boot Target VM and install VIRIO SCSI drivers from inside the VM
https://docs.fedoraproject.org/en-US/quick-docs/creating-windows-virtual-machines-using-virtio-drivers/index.html
https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.173-9/

Install both the drivers and QEMU agent:

a) Mount virtio-win.iso and install the guest QEMU agent
b) Download and run virtio-win-gt-x86.msi

and install both the drivers and QEMU agent
# 4. Switch to the disk to VirtIO SCSI 

- Stop VM 
- Add a dummy 1GB scsi disk
- Boot the machine again and make sure drivers are installed
- Stop the machine, delete 1GB disk, detach the main disk and add it as SCSI disk
- Boot and enjoy

(the idea was borrowed from here: https://forum.proxmox.com/threads/hyper-v-gen-2-windows-guest-conversion.38954/)

# 5. If VM was migrated from Hyper-V do not forget to remove Hyper-V relatd devices from Windows device manager

# 6. Install Spice server and client (this is like RDP in Windows but better) 
- Follow the steps from https://pve.proxmox.com/wiki/SPICE
