#!/bin/sh

set -e

# DBearver db client
yay -S --noconfirm --needed dbeaver

# Stack Haskell platform (dependency for ERD)
curl -sSL https://get.haskellstack.org/ | sh

# Graphviz (Graph visualization tool)
yay -S --noconfirm --needed graphviz

# ERD - entity relation diagramming tool (https://github.com/BurntSushi/erd)
git clone git://github.com/BurntSushi/erd
cd erd
stack install
cd ..
rm -rf ./erd
