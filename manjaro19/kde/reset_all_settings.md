#1. Make sure the latest version of manjaro-kde-settings package is installed
pamac search manjaro-kde-settings
if not the latest version is installed - remove it and install the latest
When migrating from Manjaro 19 to Manjaro 20 the old version olf
manjaro kde package was named 'manjaro-kde-settings' to keep backward compatibility.


#2. Copy content of /etc/skel into your ~/.config folder
sudo cp /etc/skel/.config/* ~/.config
sudo chown -R <username>:<username> ~/.config
