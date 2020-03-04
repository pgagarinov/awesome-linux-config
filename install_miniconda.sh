#!/bin/sh
set -e
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
sudo adduser miniconda
sudo sh ./Miniconda3-latest-Linux-x86_64.sh -b -p /opt/miniconda
sudo chown -R miniconda:miniconda /opt/miniconda
sudo chmod -R go-w /opt/miniconda 
sudo chmod -R go+rX /opt/miniconda 

