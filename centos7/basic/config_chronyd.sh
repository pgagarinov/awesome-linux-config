#!/bin/bash
set -e
sudo yum install chrony
sudo systemctl enable chronyd
sudo systemctl start chronyd
