#!/bin/bash
set -e
yay -S --noconfirm --needed jdk11-openjdk
mkdir -p ~/.config/JetBrains/IntelliJIdea2020.3
echo '/usr/lib/jvm/java-11-openjdk/' > ~/.config/JetBrains/IntelliJIdea2020.3/idea.jdk
