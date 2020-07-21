#!/bin/bash
set -e
sudo dnf install chrony -y
sudo systemctl enable chronyd --now
