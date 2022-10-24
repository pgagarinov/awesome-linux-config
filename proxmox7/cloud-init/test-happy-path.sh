#!/bin/bash
set -e
set -a;source ./.env.example;set +a
./destroy-initial-vm-template.sh
./download-cloud-init-images.sh
./create-initial-vm-template.sh
./multiply-vm.sh
./start-stop-vms.sh start
./start-stop-vms.sh stop
./destroy-vms.sh
./destroy-initial-vm-template.sh
