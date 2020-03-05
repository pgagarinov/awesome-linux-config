#!/bin/sh
set -e
sudo sh ./NVIDIA-Linux-x86_64-440.64.run
rm ./NVIDIA-Linux-x86_64-440.64.run
sudo systemctl set-default graphical.target
