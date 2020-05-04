#!/bin/sh	
sudo sh -c "echo '%wheel        ALL=(ALL)       NOPASSWD: ALL'> /etc/sudoers.d/10-installer"
