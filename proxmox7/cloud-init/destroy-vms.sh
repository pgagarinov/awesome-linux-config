#!/bin/bash
set -e
MAIN_MSGCOLOR=`tput setaf 48`
MSGCOLOR=`tput setaf 3`
NOCOLOR=`tput sgr0`

main_msg="${MAIN_MSGCOLOR}========Destroying VMs${NOCOLOR}"
printf "$main_msg...\n"
#VM_ID_PREFIX=601
VM_ID_PREFIX=701
N_VMS=2
#TARGET_NODE_LIST=(arctic16 arctic20)
TARGET_NODE_LIST=(px2-sandbox-1 px2-sandbox-2)
for i_vm in $(seq $N_VMS)
do
   vm_cur_id=${VM_ID_PREFIX}${i_vm}
   target_node=${TARGET_NODE_LIST[i_vm-1]}

   msg="${MSGCOLOR}Stopping VM $i_vm with ID=${vm_cur_id} on node $target_node${NOCOLOR}"
   printf "${msg}...\n"
   pvesh create /nodes/$target_node/qemu/$vm_cur_id/status/stop
   printf "${msg}: done\n"
   msg="${MSGCOLOR}Destroying VM $i_vm with ID=${vm_cur_id} on node $target_node${NOCOLOR}"
   printf "${msg}...\n"
   if grep -q "\"${vm_cur_id}\"" /etc/pve/.vmlist ; then
     pvesh delete /nodes/$target_node/qemu/$vm_cur_id -skiplock -destroy-unreferenced-disks -purge
   fi
   printf "${msg}: done\n"
done

printf "$main_msg: done\n"
