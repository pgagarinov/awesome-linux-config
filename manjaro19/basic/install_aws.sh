#!/bin/sh
set -e
sudo pacman -S --noconfirm unzip
curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
unzip awscli-bundle.zip
sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws


grep -qxF 'export PATH=/usr/local/aws/bin:$PATH' ~/.zshrc || echo 'export PATH=/usr/local/aws/bin:$PATH'>> ~/.zshrc


rm ./awscli-bundle.zip
rm -rf ./awscli-bundle
