#!/bin/bash
set -e
rm -rf ~/.jupyter
mkdir ~/.jupyter
cp ../../../centos8/basic/config/.jupyter/* ~/.jupyter
