#!/bin/bash
set -e
#
MAIN_MSGCOLOR=`tput setaf 48`
MSGCOLOR=`tput setaf 3`
NOCOLOR=`tput sgr0`

main_msg="${MAIN_MSGCOLOR}=======Multiplying VMs${NOCOLOR}"
printf "${main_msg}...\n"
DATA_STORAGE_ID=xpool_vmstorage
VM_NAME_PREFIX=ubuntu-e10v9
#POOL_ID=infra-e10v9
POOL_ID=terra-pool      # <== POOL IS EXPECTED TO EXIST, IT IS NOT CREATED AUTOMATICALLY !!!
IMG_FILE_NAME=/root/jammy-server-cloudimg-amd64.img
#VM_SOURCE_ID=6000
VM_SOURCE_ID=7000
#VM_ID_PREFIX=601
VM_ID_PREFIX=701        # <== PREFIX 701 WOULD PRODUCE VM ids 7011, 7012, ... !!!
#CLONE_FLAG=--full
CLONE_FLAG=             # <== LEAVE EMPTY FOR A LINKED CLONE !!!
#
VM_IP_PREFIX=10.109.1.1 # <== 10.1.2.3 PREFIX WOULD RESULT IN IPs 10.1.2.31, 10.1.2.32, ... !!!
VM_GATEWAY=10.109.1.1
N_VMS=2                 # <== SHOLD MATCH THE LENGTH OF TARGET_NODE_LIST !!!
#TARGET_NODE_LIST=(arctic16 arctic20)
#                         <== REPEATE THE NAME OF A SINGLE NODE MULTIPLE TYPES
#                         <== TO CREATE MULTIPLE CLONES ON A SINGLE NODE !!!
TARGET_NODE_LIST=(px2-sandbox-1 px2-sandbox-2)
for i_vm in $(seq $N_VMS)
do
   vm_cur_id=${VM_ID_PREFIX}${i_vm}
   vm_cur_name=${VM_NAME_PREFIX}-${i_vm}
   vm_cur_ip=${VM_IP_PREFIX}${i_vm}
   msg="${MSGCOLOR}Creating VM $i_vm with ID=${vm_cur_id} and NAME=${vm_cur_name} and IP=${vm_cur_ip}${NOCOLOR}"
   printf "$msg..\n"
   qm clone $VM_SOURCE_ID ${vm_cur_id} --name ${vm_cur_name} --pool $POOL_ID $CLONE_FLAG
   printf "$msg: done\n"
   msg="${MSGCOLOR}Setting params${NOCOLOR}"
   printf "$msg...\n"
   qm set ${vm_cur_id}  --ipconfig0 ip=${vm_cur_ip}/24,gw=${VM_GATEWAY}
   printf "$msg: done\n"
   target_node=${TARGET_NODE_LIST[i_vm-1]}
   if [ `hostname` != ${target_node} ]; then
       msg="${MSGCOLOR}Migrating VM $i_vm with ID=${vm_cur_id} to node ${target_node}{NOCOLOR}"
       printf "$msg...\n"
       qm migrate ${vm_cur_id} ${target_node} --online --with-local-disks
       printf "$msg: done\n"
   else
       printf "${MSGCOLOR}VM $i_vm with ID=${vm_cur_id} is already on node $target_node, migration is skipped.${NOCOLOR}\n"      
   fi
done
#
printf "${main_msg}: done\n"
