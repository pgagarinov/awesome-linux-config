#!/bin/sh
sudo dnf install https://download.docker.com/linux/centos/7/x86_64/stable/Packages/containerd.io-1.2.6-3.3.el7.x86_64.rpm
sudo dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
sudo dnf install docker-ce
sudo systemctl disable firewalld
sudo systemctl stop firewalld
sudo systemctl enable --now docker
sudo usermod -aG docker $USER
