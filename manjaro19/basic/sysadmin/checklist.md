## 1. Enable swap as a separate partition 
- use size = 1.5 of RAM size
- use vm.swappiness=10 as per https://wiki.archlinux.org/index.php/swap#Swappiness

## 2. Add user to docker group
sudo usermod -aG docker <username>

## 3. Add user to libvirt group
sudo usermod -aG libvirt <username>

## 4. Change shell to zsh
see ./change_to_zsh.sh script

## 5. Enable parallel compression for AUR packages as per
https://wiki.archlinux.org/index.php/Makepkg#Utilizing_multiple_cores_on_compression
