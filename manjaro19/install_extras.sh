#enable AUR in pamac
sudo sed --in-place "s/#EnableAUR/EnableAUR/" "/etc/pamac.conf" 

# Install yay installer
sudo pacman -S --noconfirm yay

# Install Grub Customizer
sudo pacman -S --noconfirm grub-customizer

# Install wavemon
sudo pacman -S --noconfirm wavemon


# Install Vivaldi browser
yay -Sy --noconfirm vivaldi
sudo /opt/vivaldi/update-ffmpeg

# Install Brave Browser
sudo pacman -S --noconfirm brave

# Install Zoom
yay -Sy --noconfirm zoom 

# Install Viber only for a current user
flatpak remote-add --user flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install -y --user flathub com.viber.Viber

# update desktop shortcuts (just in case)
update-desktop-database ~/.local/share/applications


# Disable bookmarks search in Krunner
mkdir -p ~/.local/share/kservices5
sed 's/EnabledByDefault=true/EnabledByDefault=false/' \
    /usr/share/kservices5/plasma-runner-bookmarks.desktop \
    > ~/.local/share/kservices5/plasma-runner-bookmarks.desktop

# Install timeshift for local backups
sudo pacman -S --noconfirm timeshift

# Bleachbit for cleaning the system
sudo pacman -S --noconfrm bleachbit

# Install goldendict
sudo pacman -S goldendict

# Install Slack for Desktop
yay -S --noconfirm slack-desktop

# Install Skyp
#yay -S --noconfirm skype
yay -S --noconfirm skypeforlinux-stable-bin

# Install PyCharm professional (should be the latest)
yay -S --noconfirm pycharm-professional

# Cool file manager
sudo pacman -S --noconfirm krusader

# Cool Multi-window terminal
sudo pacman -S --noconfirm terminator

# Matrix-like terminal-based screen-saver
sudo pacman -S --noconfirm cmatrix 

# VSCode
sudo pacman -S --noconfirm code

# Libre Office and Microsoft fonts 
flatpak install -y flathub org.libreoffice.LibreOffice
yay -S --noconfirm ttf-ms-fonts
yay -S --noconfirm ttf-vista-fonts

# Install FileZilla
sudo pacman -S --noconfirm filezilla

# Install GIMP image editor
sudo pacman -S --noconfirm gimp

# Virt viewer is SPICE client
# https://www.spice-space.org/spice-user-manual.html#spice-client
sudo pacman -S --noconfirm virt-viewer

# Virt manager is UI app for managing KVM VMs
# https://wiki.manjaro.org/index.php?title=Virt-manager
sudo pacman -S --noconfirm virt-manager qemu vde2 ebtables dnsmasq bridge-utils openbsd-netcat
sudo systemctl enable libvirtd.service
sudo systemctl start libvirtd.service

# KeePassXC password manager
sudo pacman -S --noconfirm keepassxc
