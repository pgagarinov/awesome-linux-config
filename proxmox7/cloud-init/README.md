# VM provisioning scripts based on Cloud Init images

## 1. Login to one of the nodes of your proxmox cluster
- Use either ssh or "Shell" in PVE Web UI

## 2. Clone this repo and cd to this folder
- Install git if missing: `apt install git`
- Clone the repo: `git clone https://github.com/Alliedium/awesome-linux-config.git`
- Change you current directory: `cd ./awesome-linux-config/proxmox7/cloud-init`

## 3. Copy the configuration and adjust it to match your case 
- Create your own env file using the provided example: `cp ./.env.example ./.env`
- Adjust the parameters (with self-explanatory names) inside `./.env` to match your PVE configuration.

## 4. Export variables from your configuration
 - Export environment variables from your env file: `set -a; source ./.env; set +a`

## 5. Download cloud init images
The images are downloaded into a folder defined by "Pz_CLOUD_INIT_IMAGE_DIR" environment variable.
- `./download-cloud-init-images.sh` 
All downloaded images are given ".orig" extension. Please make sure to use that extension when referring 
to the image file via `Pz_IMG_FILE_NAME` env variable (this variable is used by `./create-template.sh` script).

## 6. (Optional) Customize cloud init images.
- `./customize-cloud-init-images.sh`
This script uses *libguestfs* toolkit (namely https://libguestfs.org/virt-customize.1.html) to 
- inject extra packages (like "qemu-guest-agent" e.g.) to
- remove some packages and services (like "snap" e.g.) from
each disk images in the directory controlled by "Pz_CLOUD_INIT_IMAGE_DIR" environment variable 
without actually creating/starting a virtual machine. Only the images with ".orig" extension 
are customized. The customized images are given ".custom" extension
while preserving the original image files.

The list of extra packages to be installed into cloud images is regulated by 
"Pz_CLOUD_INIT_INSTALL_PKG_LIST" environment variable that is expected to contain 
a comma-separated list of package names. Please note that all the packages defined by this
variable are expected to have the same names across all Linux distributions images for which
are found in "Pz_CLOUD_INIT_IMAGE_DIR". If this is not the case for some package - please consider
writing a special script for that specific Linux distro and integrating it into the top-level
"customize-cloud-init-images.sh" script (see below).

### Special scripts for specific Linux distros
Please note that some images are customized
in a special manner by "_customize_<distro-name>.sh" scripts that are not intended to be called directly.
Such an approach allows to deal with packages (and the ways of installing/removing/configuring them)
that are specific to some distributions (or at least named specifically).
Currently the following Linux distros are given a special customization treat:
- Ubuntu Jammy. 
  - Image prefix (used as an indicator of an image file being related to the specific distribution): "jammy"
  - Script name (not intended to be used directly): "_customize_ubuntu_jammy.sh"
- <TBA>

Prior to customizing the images the script check for the presence of `libguestfs-tools` package on 
on the proxmox node and if the package is missing - it is installed automatically.

## 7. Create VM template
- `./create-template.sh`
This script uses `Pz_IMG_FILE_NAME` variable to refer to image file. You are free to choose between
- original images having ".orig" extension and downloaded via `download-cloud-init-images.sh`
- customized images having ".custom" extension and produced by `customized-cloud-init-images.sh` 

## 8. Clone VMs across different nodes
- `./create-vms.sh`

## 9. Start all the cloned VMs
- `./start-stop-vms.sh start`

## 10. Stop all the cloned VMs (Optional)
- `./start-stop-vms.sh stop`

## 11. Destroy all the cloned VMs (Optional) 
- `./destroy-vms.sh`

## 12. Destroy the VM template (Optional)
- `./destroy-template.sh`

# Batch commands
## 1. Create the template, create and start VMs
```
./batch-create-start.sh
```

## 2. Stop and destroy the VMs, then destroy the template

```
./batch-stop-destroy.sh
```
# Tests
- `./test-happy-path-granular.sh` - this test basically performs the full cycle of VM creation and destruction.
- `./test-happy-path-batch.sh` - this test verifies batch scripts.
# Other OSS Proxmox tools
The scripts above are intended for creating 1 standard VM on every PVE. This can have many application, setting up VMs for K8s Cluster is one of them. 
If you are interested in automation for PVE - have a look at

 - https://github.com/marrobHD/proxmox-tools
 - https://github.com/Corsinvest/cv4pve-cli
 - https://github.com/Tontonjo/proxmox_toolbox
 - https://github.com/tteck/Proxmox
 - https://github.com/Telmate/terraform-provider-proxmox
