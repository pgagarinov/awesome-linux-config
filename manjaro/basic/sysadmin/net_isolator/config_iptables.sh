#!/bin/sh
set -e

full_path=$(realpath $0)
dir_path=$(dirname $full_path)

sudo python3 $dir_path/config_iptables.py "$@"
