#!/bin/bash
set -e
rm -rf /home/ALLIEDTESTING/$USER/.jupyter
mkdir ~/.jupyter
cp ../../../centos8/basic/config/.jupyter/* ~/.jupyter
