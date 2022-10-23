#!/bin/bash
set -e
MAIN_MSGCOLOR=`tput setaf 48`
MSGCOLOR=`tput setaf 3`
NOCOLOR=`tput sgr0`


main_msg="${MAIN_MSGCOLOR}======Creating VM template${NOCOLOR}"
printf "$main_msg...\n"
CLOUD_INIT_IMAGE_DIR=/root/cloud-init-images
VM_NAME=ubuntu-shared-0
#POOL_ID=infra-e10v9
POOL_ID=terra-pool
IMG_FILE_NAME=$CLOUD_INIT_IMAGE_DIR/jammy-server-cloudimg-amd64.img
VM_ID=7000
USER_NAME=suser
USER_PW=superpw
USER_PUB_KEY_FILE_NAME=/root/.ssh/id_rsa_cloudinit.pub
# Please avoid using incompatible combinations of storages and disk formats,
# some storages (marked with "block" in https://pve.proxmox.com/wiki/Storage) 
# do not support "qcow2" disk format
# ============================
#   storage vs format cheatsheet:
# ============================
# LVM, LVM-Thin - "raw"
# ZFS, ZFS - "raw"
# CIFS, NFS - "qcow2" (if "raw" is used - no snapshots)
# iSCSI - "raw" (but no snapshots)
# ===========================
#
#DATA_STORAGE_ID=xpool_vmstorage
#DATA_STORAGE_ID=freenas-zfs-iscsi
#DATA_STORAGE_ID=truenas-nfs
DATA_STORAGE_ID=px2-1-nfs
#DATA_STORAGE_ID=local-lvm
DISK_FORMAT='qcow2'
#DISK_FORMAT='raw'
#
NET_BRIDGE=vmbr0
#NET_BRIDGE=e10v9
RAM=4096
VCPU=12
#
msg="${MSGCOLOR}Creating VM${NOCOLOR}"
printf "$msg...\n"
# mtu=1 means use host's MTU for the corresponding bridge
qm create $VM_ID --memory $RAM --cores $VCPU  --name $VM_NAME --net0 virtio,bridge=$NET_BRIDGE,mtu=1 --pool $POOL_ID
printf "$msg: done\n"
#
# sometimes it is necessary to increase VMs disk size
# if so - please run
# qemu-img resize $IMG_FILE_NAME +1G
#
if [ "$DISK_FORMAT" == 'raw' ]; then
  import_disk_cmd_suffix=""
  after_import_disk_path="$DATA_STORAGE_ID:vm-$VM_ID-disk-0"
elif [ "$DISK_FORMAT" == 'qcow2' ]; then
  import_disk_cmd_suffix='--format qcow2'
  after_import_disk_path="$DATA_STORAGE_ID:$VM_ID/vm-$VM_ID-disk-0.qcow2"
else
  printf "${MSGCOLOR}Format $DISK_FORMAT is unsupported${NOCOLOR}"
  exit 1
fi

#
printf "${MSGCOLOR}Using DISK_FORMAT=$DISK_FORMAT${NOCOLOR}\n"
msg="${MSGCOLOR}Adding suffix $import_disk_cmd_suffix to qm import command${NOCOLOR}"
printf "$msg...\n"
qm importdisk $VM_ID $IMG_FILE_NAME $DATA_STORAGE_ID $import_disk_cmd_suffix
printf "$msg: done\n"
#
msg="${MSGCOLOR}Attaching disk to VM using disk_path=${after_import_disk_path}${NOCOLOR}"
printf "$msg...\n"
qm set $VM_ID --scsihw virtio-scsi-pci --virtio0 $after_import_disk_path
printf "$msg: done\n"
#
msg="${MSGCOLOR}Setting various VM parameters${NOCOLOR}"
printf "$msg...\n"
qm set $VM_ID --ide2 $DATA_STORAGE_ID:cloudinit
qm set $VM_ID --boot c --bootdisk scsi0
printf "$msg: done\n"
#
msg="${MSGCOLOR}Setting CloudInit parameters${NOCOLOR}"
printf "$msg...\n"
qm set $VM_ID --ipconfig0 ip=10.109.1.11/20,gw=10.109.1.1
qm set $VM_ID --nameserver 10.109.1.1
qm set $VM_ID --ciuser $USER_NAME
qm set $VM_ID --cipassword $USER_PW
qm set $VM_ID --sshkey $USER_PUB_KEY_FILE_NAME
printf "$msg: done\n"
#
msg="${MSGCOLOR}Converting VM to a template${NOCOLOR}"
printf "$msg...\n"
# The following command can throw a warning like the following one
#   "command '/usr/bin/chattr +i /mnt/pve/truenas-nfs/images/7000/base-7000-disk-0.qcow2' failed: exit code 1"
# on NFS storage
# because NFS doesn't have a concept of immutable files
# see https://unix.stackexchange.com/questions/90326/chattr-i-error-on-nfs for details
#
qm template $VM_ID
printf "$msg: done\n"
#
printf "$main_msg: done\n"
