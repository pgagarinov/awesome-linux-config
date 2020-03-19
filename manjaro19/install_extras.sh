#enable AUR in pamac
sudo sed --in-place "s/#EnableAUR/EnableAUR/" "/etc/pamac.conf" 

# Install yay installer
sudo pacman -S --noconfirm yay

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
