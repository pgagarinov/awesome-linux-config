# Instructions

## 1. Update system and reboot
	```
	sudo pacman -Syyuu
    sudo reboot now
	```
## 2. Clone this repository
	```bash
	git clone git@github.com:Alliedium/awesome-inux-config.git
	```

## 3. Run system-wide scripts from basic folder and reboot
	```bash
	cd awesome-linux-config/manjaro/basic/
    ./install_all.sh
    # make sure the script above runs till the end!!!
    sudo reboot now
	```

## 4. Change your shell to zsh and login/logout
	```bash
	cd awesome-linux-config/manjaro/basic/sysadmin
    ./change_to_zsh.sh
    # login and logout
	```
## 5. Install user-specific scripts
	```bash
	cd awesome-linux-config/manjaro/basic/user
    ./install_all_user.sh
    # make sure the script above runs till the end!!!
    sudo reboot now
	```
