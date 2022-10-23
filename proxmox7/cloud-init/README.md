# VM provisioning scripts based on Cloud Init images

## 1. Clone this repo and cd to this folder
Run `cd /awesome-linux-config/proxmox7/cloud-init`
## 2. Adjust the script configuration to match your case 
Make sure that constants (with self-explanatory names) in every script match your PVE configuration.
## 3. Login to one of the nodes of your proxmox cluster
Use either ssh or "Shell" in PVE Web UI
## 4. Download cloud init images
Run `./download-cloud-init-images.sh` to download cloud images. Feel free to edit the script to add links to cloud images of your own
## 5. Create VM template
- Copy `./create-init-vm-ubuntu-jammy.sh` to `create-init-vm-my-case.sh`
- Modify constants in the header of the script to match your case
- Run `./create-init-vm-my-case.sh`
## 6. Clone VMs across different nodes
- Modify constants in the header of the script to match your case
- Run `./multiply-vm.sh`

## 7. (Optional) Destroy the created VMs 
- Modify constants in the header of the script to match your case
- Run `./destroy-vms.sh`

## 8. (Optional) Destroy the VM template
- Run `qm destroy <your_vm_template_id>`

# Other OSS Proxmox tools
The scripts above are intended for creating 1 standard VM on every PVE. This can have many application, setting up VMs for K8s Cluster is one of them. 
If you are interested in automation for PVE - have a look at

 - https://github.com/marrobHD/proxmox-tools
 - https://github.com/Corsinvest/cv4pve-cli
 - https://github.com/Tontonjo/proxmox_toolbox
 - https://github.com/tteck/Proxmox
 - https://github.com/Telmate/terraform-provider-proxmox
