#!/bin/sh
set -e
sudo dnf install xrdp 
sudo systemctl enable xrdp --now
sudo systemctl status xrdp
