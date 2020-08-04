#!/bin/sh
set -e

DNSDOMAINAME=@$(dnsdomainname)
if [[ -z $(dnsdomainname) ]];
then
    DNSDOMAINAME=$(dnsdomainname)
fi

echo $DNSDOMAINNAME
echo $USER$DNSDOMAINAME

if [ ! -z "$(id $USER$DNSDOMAINAME)" ] && [ ! -z "$DNSDOMAINAME" ];
then
    echo "Domain user!"
    sudo getent passwd $USER
else
    echo "Local user!"
    sudo chsh -s $(which zsh) $USER
fi
