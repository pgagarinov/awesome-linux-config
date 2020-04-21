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
sed -i "s/deb/#deb/" /etc/apt/sources.list.d/pve-enterprise.list
grep -q "pve-no-subscription" /etc/apt/sources.list|| echo "deb http://download.proxmox.com/debian/pve buster pve-no-subscription" >> /etc/apt/sources.list
apt update
apt full-upgrade -y
pveam update

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
echo "options vfio-pci ids=10de:1b81,10de:10f0 disable_vga=1" >> /etc/modprobe.d/vfio.conf


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
# hostpci0: 0a:00,pcie=1
#   To use a physical monitor add "x-vga=on": hostpci0: 0a:00,pcie=1, x-vga=on
# 
# machine: q35,kernel_irqchip=on

# 14. reboot Proxmox host
