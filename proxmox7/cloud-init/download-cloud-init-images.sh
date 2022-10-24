#!/bin/bash
set -e
MAIN_MSGCOLOR=`tput setaf 48`
MSGCOLOR=`tput setaf 3`
NOCOLOR=`tput sgr0`

main_msg="${MAIN_MSGCOLOR}======Downloading cloud images${NOCOLOR}"
printf "$main_msg...\n"

CLOUD_INIT_IMAGE_DIR=/root/cloud-init-images

mkdir -p $CLOUD_INIT_IMAGE_DIR
#
# References:
# https://wiki.archlinux.org/title/Arch_Linux_on_a_VPS
# https://github.com/dermotbradley/create-alpine-disk-image

LINK_LIST=(
  #https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img
  https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img
  #https://download.rockylinux.org/pub/rocky/8.6/images/Rocky-8-GenericCloud.latest.x86_64.qcow2
  #https://download.rockylinux.org/pub/rocky/9.0/images/x86_64/Rocky-9-GenericCloud.latest.x86_64.qcow2
  #https://geo.mirror.pkgbuild.com/images/latest/Arch-Linux-x86_64-cloudimg.qcow2
  https://download.fedoraproject.org/pub/fedora/linux/releases/36/Cloud/x86_64/images/Fedora-Cloud-Base-36-1.5.x86_64.qcow2
)

for dl_url in "${LINK_LIST[@]}"
do
  msg="${MSGCOLOR}Downloading $dl_url${NOCOLOR}"
  printf "$msg...\n"
  file_name=${CLOUD_INIT_IMAGE_DIR}/$(basename "$dl_url")
  file_name_tmp=${file_name}.tmp
  if [[ ! -e "$file_name" ]]
  then
    wget -O ${file_name_tmp} $dl_url -c && mv ${file_name}{.tmp,}
  else
    # clean garbage
    [ -e $file_name_tmp ] && rm ${file_name_tmp}
  fi
  printf "$msg: done\n"
done
printf "$main_msg: done\n"

