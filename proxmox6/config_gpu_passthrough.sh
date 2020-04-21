#!/bin/bash

# Reference guides:
# https://pve.proxmox.com/wiki/Pci_passthrough
# https://pve.proxmox.com/wiki/PCI(e)_Passthrough


# 1. Try to make sure that BIOS post messages are displayed on GPU different from the one you are going to pass through
#
# 2. Disable Legacy Boot (CSM) in BIOS
#
# 3. Make sure that IOMMU Interrupt Remapping (a feature of VT-d) is enabled in BIOS,
#    Follow https://pve.proxmox.com/wiki/Pci_passthrough#IOMMU_Interrupt_Remapping to check that IOMMU interrup remapping is enabled
#
# 4. Verify IOMMU Isolation, (some PCIe slots on some motherboards can be shared with other devices). The passed-through PCIe device need to have an isolated group
#    Follow https://pve.proxmox.com/wiki/Pci_passthrough#Verify_IOMMU_Isolation
#
# 5. Get list of IDs via `lspci -vnn |grep -iP 'nvidia|vfio-pci|gpu'

# 6. Update packages
#sed -i "s/deb/#deb/" /etc/apt/sources.list.d/pve-enterprise.list
#grep -q "pve-no-subscription" /etc/apt/sources.list|| echo "deb http://download.proxmox.com/debian/pve buster pve-no-subscription" >> /etc/apt/sources.list
#apt update
#apt full-upgrade -y
#pveam update

# 7. Loading vfio-pci early
echo "vfio" >> /etc/modules
echo "vfio_iommu_type1" >> /etc/modules
echo "vfio_pci" >> /etc/modules
echo "vfio_virqfd" >> /etc/modules

# 8. Enabling IOMMU (requires Proxmox installed via UEFI
grep -q "intel_iommu=on" /etc/kernel/cmdline || echo -n "`cat /etc/kernel/cmdline` intel_iommu=on" >/etc/kernel/cmdline
grep -q "video=vesafb:off" /etc/kernel/cmdline || echo -n "`cat /etc/kernel/cmdline` video=vesafb:off" >/etc/kernel/cmdline
grep -q "video=efifb:off" /etc/kernel/cmdline || echo -n "`cat /etc/kernel/cmdline` video=efifb:off" >/etc/kernel/cmdline
pve-efiboot-tool refresh


# 9. Bluescreen at boot since Windows 10 1803 and problems at boot with Linux Guests
echo "options kvm ignore_msrs=1" >> /etc/modprobe.d/kvm.conf

# 10. Binding vfio-pci via device ID
#   Please make sure to replace IDs given here as an example with actual GPU function IDs
#   Extracted via lspci    
echo "options vfio-pci ids=10de:1f02,10de:10f9,10de:1ada,10de:1adb  disable_vga=1" >> /etc/modprobe.d/vfio.conf


# 11. Blacklist GPU drivers on host
echo "blacklist nouveau" >> /etc/modprobe.d/blacklist.conf
echo "blacklist nvidia" >> /etc/modprobe.d/blacklist.conf
echo "blacklist radeon" >> /etc/modprobe.d/blacklist.conf

# 12. Blacklist USB ports integrated into NVidia GPU
echo "blacklist ucsi_ccg" >> /etc/modprobe.d/blacklist-nvidia-usb.conf 
update-initramfs -u -k all


# 13. Add a few extra parameters to VM config file located at /etc/pve/qemu-server/<VMID>.conf:
# agent: 1
# bios: ovmf
#   
# hostpci0: 03:00,pcie=1
#   To use a physical monitor add "x-vga=on": hostpci0: 03:00,pcie=1, x-vga=on
# 
# machine: q35,kernel_irqchip=on
#
# mind https://forum.proxmox.com/threads/fix-for-pci-passthrough-and-issues-with-proxmox-6-gui-regex-that-needs-resolving-after-upgrade.56507/

# 14. reboot Proxmox host

#---------REFERENCES----------
#https://pve.proxmox.com/wiki/Pci_passthrough
#https://pve.proxmox.com/wiki/PCI(e)_Passthrough
#https://forum.proxmox.com/threads/fix-for-pci-passthrough-and-issues-with-proxmox-6-gui-regex-that-needs-resolving-after-upgrade.56507/
#https://forum.proxmox.com/threads/gpu-passthrough-tutorial-reference.34303/
#https://forum.proxmox.com/threads/bug-gpu-passthrough-not-working-on-vmlinuz-5-3-10-1-pve-v-6-1.61356/
#https://gist.github.com/MakiseKurisu/21b08e5f6537a5b0a08a34c2382dd244
#https://techblog.jeppson.org/2019/10/proxmox-6-nvidia-gpu-passthrough-fix/
#https://forum.proxmox.com/threads/vm-w-pcie-passthrough-not-working-after-upgrading-to-6-0.56021/
#https://www.youtube.com/watch?v=3yhwJxWSqXI&t=319s
#https://www.reddit.com/r/homelab/comments/b5xpua/the_ultimate_beginners_guide_to_gpu_passthrough/
#https://www.reddit.com/r/Proxmox/comments/cklaz4/cant_get_iommu_going_for_pcie_passthrough/
#https://forum.proxmox.com/threads/2-problems-backup-hangs-and-start-failed-got-timeout.61860/
#https://forum.level1techs.com/t/getting-dreaded-error-code-43-when-trying-to-passthrough-an-nvidia-gpu-to-a-windows-virtual-machine-using-qemu-kvm-in-proxmox/122405/29
#https://forum.level1techs.com/t/proxmox-vm-wont-start-if-pci-passthrough-is-enabled-with-more-than-96gb-memory/151888/20
#https://forum.manjaro.org/t/stuck-at-started-tlp-system-startup-shutdown/29894/21
#https://forum.odroid.com/viewtopic.php?t=35608
#https://www.reddit.com/r/VFIO/comments/fyg1gw/rtx2070_has_a_usb_and_serial_bus_controller_i/
#https://askubuntu.com/questions/1155263/new-install-desktop-ubuntu-19-04-shows-error-message-ucsi-ccg-0-0008-failed-to
#https://forum.manjaro.org/t/kvm-with-libvirt-manjaro-iso-boot-stuck-at-tlp/118105/6
#https://forum.manjaro.org/t/qemu-kvm-install-media-fails-to-boot-with-uefi-firmware/14354

