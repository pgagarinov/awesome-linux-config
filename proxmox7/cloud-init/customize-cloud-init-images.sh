#!/bin/bash
#
# Customizes PVE VM Cloud Init images with ".orig" extension located in predefined folder. 
# Customized images are then placed into the same folder with "custom" extension.
#
# Usage:
#  $ ./customize-cloud-init-images.sh
#
set -e
MAIN_MSGCOLOR=`tput setaf 48`
MSGCOLOR=`tput setaf 3`
NOCOLOR=`tput sgr0`
ERRCOLOR=`tput setaf 196`

main_msg="${MAIN_MSGCOLOR}Customizing cloud images from \"$Pz_CLOUD_INIT_IMAGE_DIR\" directory${NOCOLOR}"
printf "$main_msg...\n"

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

REQUIRED_PKG="libguestfs-tools"
PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $REQUIRED_PKG|grep -c "install ok installed" || true)

if [ "1" != "$PKG_OK" ]; then
  msg="${MSGCOLOR}Setting up $REQUIRED_PKG${NOCOLOR}"
  printf "$msg...\n"
  apt-get --yes install $REQUIRED_PKG
  printf "$msg: done\n"
else
  printf "${MSGCOLOR}$REQUIRED_PKG is installed, no action required\n${NOCOLOR}"
fi

for orig_file in "${Pz_CLOUD_INIT_IMAGE_DIR}"/*.orig
do
  msg="${MSGCOLOR}Customizing $orig_file${NOCOLOR}"
  printf "$msg...\n"
  custom_file="${orig_file%.orig}.custom"
  custom_file_tmp=${custom_file}.tmp
  cp -- "$orig_file" "$custom_file_tmp"
  #
  # check if image file name starts with "jammy" if so - special treat
  if [[ "$custom_file_tmp" =~ .*\/jammy[^\/]+$ ]]
  then
    echo "Special treat for Ubuntu Jammy"
    $SCRIPT_DIR/_customize-ubuntu-jammy.sh $custom_file_tmp && mv $custom_file_tmp $custom_file
  else
    echo "Standard treat for the image"
    virt-customize -a $custom_file_tmp --install $Pz_CLOUD_INIT_INSTALL_PKG_LIST && mv $custom_file_tmp $custom_file
  fi
  if [[ -e "$custom_file_tmp" ]]
  then
    rm $custom_file_tmp
  fi
  printf "$msg: done\n"
done

printf "$main_msg: done\n"
