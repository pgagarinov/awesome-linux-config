#!/bin/zsh
set -e
ALLURE_VERSION=2.13.7

rm -rf ~/.allure
mkdir ~/.allure

wget "https://repo.maven.apache.org/maven2/io/qameta/allure/allure-commandline/${ALLURE_VERSION}/allure-commandline-${ALLURE_VERSION}.tgz"
tar -zxf "allure-commandline-${ALLURE_VERSION}.tgz" -C ~/.allure && rm -f "allure-commandline-${ALLURE_VERSION}.tgz"
ln -s "$HOME/.allure/allure-${ALLURE_VERSION}/bin/allure" ~/.allure/allure  

grep -qxF 'export PATH="$HOME/.allure:$PATH"' ~/.zshrc || sed -i '1s/^/export PATH="$HOME\/.allure:$PATH"\n/' ~/.zshrc
echo "update zshrc"
source ~/.zshrc || true
