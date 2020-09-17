#!/bin/bash
set -e
# Disable bookmarks search in Krunner
mkdir -p ~/.local/share/kservices5
sed 's/EnabledByDefault=true/EnabledByDefault=false/' \
    /usr/share/kservices5/plasma-runner-bookmarks.desktop \
    > ~/.local/share/kservices5/plasma-runner-bookmarks.desktop

# ERD - entity relation diagramming tool (https://github.com/BurntSushi/erd)
rm -rf ./erd
git clone https://github.com/BurntSushi/erd.git
cd erd
stack install
cd ..
rm -rf ./erd


echo "include /usr/share/nano-syntax-highlighting/*.nanorc" >> ~/.nanorc


# update desktop shortcuts (just in case)
update-desktop-database ~/.local/share/applications||true