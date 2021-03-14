#!/bin/bash
set -e
full_path=$(realpath $0)
dir_path=$(dirname $full_path)
config_dir=$dir_path/config
rm -rf ~/.vscode-oss
if command -v code &> /dev/null
then
	cat $config_dir/vscode_extension_list.txt | while read extension || [[ -n $extension ]];
	do
	  code --install-extension $extension
	done
fi
