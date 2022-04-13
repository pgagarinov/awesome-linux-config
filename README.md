# Awesome Linux Configuration Scripts for Arch Linux, Manjaro, CentOS 7 and Rocky Linux 8
A curated set of awesome configuration scripts for various Linux-based systems.

The following scripts configure 
* Arch Linux/ Manjaro Linux as a workstation for Java, Python, Julia, Rust and JavaScript application development.
* CentOS 7/CentOS 8 Linux as a server or a remote workstation

*All scripts install*

Java 8, 11, Maven, NodeJS, Docker, Docker Compose, Minikube, Miniconda, Jupyter Notebook/JupyterLab default configuration, zsh, OhMyZsh with powerlevel10k theme and a few very userful extensions, AWS cli v1, git, broot, fd-find, fzf, mc, far2l, tig, htop, mc, nano, screen, ncdu, tmux, exa, sk,  Rust, Allure commandline, 

*Additionally Arch Linux / Manjaro scripts install*

NeoVim configured for development in Rust language, Julia, Terminator, Kdenlive, OBStudio, Flameshot, Libre Office, IntelliJ Idea Ultimate Edition, PyCharm Professional, DataGrip, IntelliJ Webstorm, VSCode (+ extensions for Python, Rust, Julia, git and markdown), GitHub Desktop, DrawIO Desktop, Gimp, VLC, KeePassXC, Stack Haskell Platform, Graphviz, Erd, PgAdmin4, DBeaver, Slack, Zoom, Bleach, Filezilla Client, Skype, Krusader, Virt-viewer, Google Chrome, Firefox, Brave Browser, Geckodriver, Chrome Driver, Timeshift

# How to install
```
git clone git@github.com:Alliedium/awesome-linux-config.git
cd ./awesome-linux-config/<YourOs>/basic
```

## For server
```
./install_4server_all.sh
```
## For workstation
### 1. Install system-wide packages
Run the following script from under a user with sudo permissions. 
Please do not add **sudo** in from of the command!
```
./install_all.sh
```
### 2. Configure user account
Assuming you want to set up the user account for user "new_user" do the following

1. From under a user with sudo permissions run the following command
```
sudo chsh -s /bin/zsh new_user
sudo usermod -aG docker new_user
```

2. From under "new_user" account run 
```
./user/install_all_user.sh
```
