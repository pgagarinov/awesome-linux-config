#!/bin/bash
set -e
mkdir -p ~/.config/JetBrains/IntelliJIdea2020.3
mkdir -p ~/.config/JetBrains/IntelliJIdea2021.1
mkdir -p ~/.config/JetBrains/IntelliJIdea2021.2
echo '/usr/lib/jvm/java-11-openjdk/' > ~/.config/JetBrains/IntelliJIdea2020.3/idea.jdk
echo '/usr/lib/jvm/java-11-openjdk/' > ~/.config/JetBrains/IntelliJIdea2021.1/idea.jdk
echo '/usr/lib/jvm/java-11-openjdk/' > ~/.config/JetBrains/IntelliJIdea2021.2/idea.jdk
