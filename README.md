# Awesome Linux Configuration Scripts
A curated set of awesome configuration scripts for various Linux-based systems.

The following scripts configure 
* Manjaro Linux as a workstation for Java and Python application development.
* CentOS 7/CentOS 8 Linux as a staging environment for Java and Python-based applications.

All scripts install 

* Java 8
* Maven
* NodeJS
* Docker, Docker Compose
* Minikube
* Miniconda
* Jupyter Notebook/JupyterLab default configuration
* zsh
* OhMyZsh with powerlevel10k theme and a few very userful extensions
* AWS cli v1
* git
* broot, fd-find, fzf, mc, far2l, tig, htop, mc, nano, vim, screen, ncdu, tmux
* Rust

Additionally Manjaro scripts install

* Terminator
* Kdenlive
* OBStudio
* Flameshot
* Libreoffice
* IntelliJ Idea Ultimate Edition
* PyCharm Professional
* DataGrip
* IntelliJ Webstorm
* VSCode
* GitHub Desktop
* DrawIO Desktop
* Gimp
* VLC
* KeePassXC
* Stack Haskell Platform
* Graphviz
* Erd
* PgAdmin4
* DBeaver
* Slack
* Zoom
* Bleach
* Filezilla Client
* Skype
* Krusader
* Virt-viewer
* Google Chrome
* Firefox
* Brave Browser
* Geckodriver
* Chrome Driver
* Timeshift

## Manjaro
### Prerequisites
1. Sudo permissions for your user
2. GIT (type `sudo pacman -S git` to install)

### How to install
```
git clone git@github.com:Alliedium/awesome-linux-config.git
cd ./awesome-linux-config/manjaro/basic
./install_all.sh
./user/install_all_user.sh
sudo chsh -s /bin/zsh <your_user_name>
sudo usermod -aG docker <your_user_name>
```

## CentOS 8
### Prerequisites
1. Sudo permissions for your user
2. GIT (type `sudo dnf install git` to install)

### How to install
```
git clone git@github.com:Alliedium/awesome-linux-config.git
cd ./awesome-linux-config/centos8/basic
./install_all.sh
```

## CentOS 7
### Prerequisites
1. Sudo permissions for your user
2. GIT (type `sudo yum install git` to install)

### How to install
```
git clone git@github.com:Alliedium/awesome-linux-config.git
cd ./awesome-linux-config/centos7/basic
./install_all.sh```
