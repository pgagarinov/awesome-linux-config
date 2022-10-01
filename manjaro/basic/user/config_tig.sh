#!/bin/bash
set -e
full_path=$(realpath $0)
dir_path=$(dirname $full_path)
cp $dir_path/config/.tigrc ~
