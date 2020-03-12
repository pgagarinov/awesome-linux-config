#!/bin/sh
set -e
sudo dnf install xrdp -y 
sudo systemctl enable xrdp --now
sudo systemctl start xrdp
