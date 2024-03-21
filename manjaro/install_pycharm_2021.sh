#!/bin/bash
set -e
 
# Define ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
RESET='\033[0m'
 
# Define paths and file names
FULL_PATH=$(realpath $0)
DIR_PATH=$(dirname $FULL_PATH)
 
yay -R pycharm-community-edition --noconfirm || true
 
eval "$(micromamba shell hook --shell=bash)"
 
cd $DIR_PATH
if [ -d "./pycharm-professional" ] ; then
  rm -rf ./pycharm-professional
fi
git clone https://aur.archlinux.org/pycharm-professional.git
cd ./pycharm-professional
 
# This is version 2021.2.2-2
git checkout 19310af76b80fcdfce8087d0a0961491dac75118
 
# Here it is crucial to use namely Python 3.7 with Cython
micromamba create -n pycharm_compile python=3.7 cython -c conda-forge -y
micromamba activate pycharm_compile
 
makepkg -si --noconfirm
 
micromamba deactivate
micromamba remove -n pycharm_compile --all -y
rm -rf $DIR_PATH/pycharm-professional
 
#
