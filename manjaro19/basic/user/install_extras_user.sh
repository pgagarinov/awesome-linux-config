# Install Viber only for a current user
flatpak remote-add --user flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install -y --user flathub com.viber.Viber

# Libre Office
flatpak install -y --user flathub org.libreoffice.LibreOffice

#Install EasySSH
flatpak install -y --user flathub com.github.muriloventuroso.easyssh
#yay -S --noconfirm --needed easyssh
