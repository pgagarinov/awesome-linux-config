#!/bin/bash
set -e
rm -rf ~/.jupyter
mkdir ~/.jupyter
full_path=$(realpath $0)
dir_path=$(dirname $full_path)

cp -r $dir_path/config/.jupyter/. ~/.jupyter/
cp $dir_path/config/.jupyter/jupyter_notebook_config.py ~/.jupyter/jupyter_lab_config.py
cp $dir_path/config/.jupyter/jupyter_notebook_config.json ~/.jupyter/jupyter_lab_config.json
