#!/bin/bash
#
# Customizes Ubuntu Jammy cloud image by removing snap and installing a few packages.
#
# Usage:
#  $ ./customize-ubuntu-jammy.sh <path-to-image>
#
set -e

msg="===Installing packages"
printf "$msg...\n"
virt-customize -a $1 --install nala,qemu-guest-agent
printf "$msg: done\n"

msg="===Choosing the fastest mirrors"
printf "$msg...\n"
virt-customize -a $1 --run-command 'mkdir /run/lock; printf "y\n"|nala fetch --fetches 3 -c RU -c GE --auto'
printf "$msg: done\n"

msg="===Removing Snap"
printf "$msg...\n"
virt-customize -a $1 --run-command 'bash -c "$(curl -fsSL https://raw.githubusercontent.com/Alliedium/remove-snap/main/remove-snap.sh)"'
printf "$msg: done\n"

msg="===Cleaning via Nala"
printf "$msg...\n"
virt-customize -a $1 --run-command 'nala clean'
printf "$msg: done\n"


