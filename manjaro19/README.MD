# Instructions

Please follow the steps below:
1. [**Important** ]Update the system
	```bash
	sudo pacman -Syyu
	```
2. [**Important** ] After successfully updates reboot the system
	```bash 
	 reboot
	 ```
3.  Clone this repository
	```bash
	git clone https://github.com/emptyshell/centos-config.git
	```
4.  Navigate to the **basic** folder
	```bash
	cd centos-config/manjaro19/basic/
	```
5.  Run the **install_all.sh**
	```bash
	 ./install_all.sh
	 ```
6.  After the script run reboot the system
	```bash
	reboot
	```
## Install antivirus
There is an antivirus install script that is not included in **install_all.sh**
* To execute the **install_eset_nod32.sh** run:

	```bash
	./install_eset_nod32.sh
	```
	
* And follow the graphical interface as in this [guide](https://support.eset.com/en/kb2653-download-and-install-eset-nod32-antivirus-4-for-linux-desktop)

* After the script run reboot the system
	```bash
	reboot
	```
