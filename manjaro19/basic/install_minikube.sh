#!/bin/sh
set -e
sudo pacman -S --noconfirm minikube
sudo pacman -S --noconfirm kubectl
minikube start
minikube stop
#type `minikube dashboard` or `minikube dashboard --url` to start Kubernetes dashboard
