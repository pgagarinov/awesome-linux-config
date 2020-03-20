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

# update desktop shortcuts (just in case)
update-desktop-database ~/.local/share/applications


# Disable bookmarks search in Krunner
mkdir -p ~/.local/share/kservices5
sed 's/EnabledByDefault=true/EnabledByDefault=false/' \
    /usr/share/kservices5/plasma-runner-bookmarks.desktop \
    > ~/.local/share/kservices5/plasma-runner-bookmarks.desktop

# Install timeshift for local backups
sudo pacman -S timeshift

# Install goldendict
sudo pacman -S goldendict

# Install Slack for Desktop
yay -S --noconfirm slack-desktop

# Install Skyp
yay -S --noconfirm skype



