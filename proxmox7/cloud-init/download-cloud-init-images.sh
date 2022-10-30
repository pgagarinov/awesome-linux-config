#!/bin/bash
#
# Downloads PVE VM Cloud Init images to the predefined folder. Downloading is done in an atomic fashion to
# avoid broken/partially downloaded images. The downloaded images are given the ".orig" extension.
#
# Usage:
#  $ ./download-cloud-init-images.sh
#
set -e
MAIN_MSGCOLOR=`tput setaf 48`
MSGCOLOR=`tput setaf 3`
NOCOLOR=`tput sgr0`

main_msg="${MAIN_MSGCOLOR}======Downloading cloud images${NOCOLOR}"
printf "$main_msg...\n"

mkdir -p $Pz_CLOUD_INIT_IMAGE_DIR

eval "link_list=$Pz_LINK_LIST"

for dl_url in "${link_list[@]}"
do
  file_name=${Pz_CLOUD_INIT_IMAGE_DIR}/$(basename "$dl_url")
  file_name_tmp=${file_name}.tmp
  file_name_orig=${file_name}.orig
  if [[ ! -e "$file_name_orig" ]]
  then
    msg="${MSGCOLOR}Downloading $dl_url${NOCOLOR}"
    printf "$msg...\n"
    wget -O ${file_name_tmp} $dl_url -c && mv ${file_name_tmp} ${file_name_orig}
    printf "$msg: done\n"
  else
    # clean garbage
    [ -e $file_name_tmp ] && rm ${file_name_tmp}
    printf "${MSGCOLOR}$dl_url${NOCOLOR}: already downloaded\n"
  fi
done
printf "$main_msg: done\n"

