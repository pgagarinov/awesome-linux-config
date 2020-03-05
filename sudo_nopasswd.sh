#!/bin/sh
sudo sh -c "grep -qxF '%wheel        ALL=(ALL)       NOPASSWD: ALL' /etc/sudoers || echo '%wheel        ALL=(ALL)       NOPASSWD: ALL'>> /etc/sudoers"
