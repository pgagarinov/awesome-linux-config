#!/bin/bash
set -e
./start-stop-vms.sh stop
./destroy-vms.sh
./destroy-template.sh
./download-cloud-init-images.sh
./customize-cloud-init-images.sh
./create-template.sh
./create-vms.sh
./start-stop-vms.sh start
./start-stop-vms.sh stop
./destroy-vms.sh
./destroy-template.sh
