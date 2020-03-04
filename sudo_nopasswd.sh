#!/bin/sh
echo '%wheel        ALL=(ALL)       NOPASSWD: ALL' | sudo tee -a /etc/sudoers
