#!/bin/bash
set -e
set -a;source ./.env.example;set +a
./start-stop-vms.sh stop
./destroy-vms.sh
./destroy-template.sh
./download-cloud-init-images.sh
./create-template.sh
./multiply-vm.sh
./start-stop-vms.sh start
./start-stop-vms.sh stop
./destroy-vms.sh
./destroy-template.sh
