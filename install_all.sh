#!/bin/sh
set -e
./sudo_nopasswd.sh
./install_dev_packages.sh
./install_zsh.sh
./install_setup_git.sh
./install_miniconda.sh
./install_docker.sh
./install_rust_utils.sh
#./install_ohmyzsh.sh
