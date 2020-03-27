#!/bin/bash
set -e
#
rm -f ./docker-compose-Linux-x86_64*
#
curl -s https://api.github.com/repos/docker/compose/releases/latest \
  | grep browser_download_url \
  | grep docker-compose-Linux-x86_64 \
  | cut -d '"' -f 4 \
  | wget -qi -

chmod +x docker-compose-Linux-x86_64
#
sudo mv docker-compose-Linux-x86_64 /usr/local/bin/docker-compose
#
rm -f ./docker-compose-Linux-x86_64*

