#!/bin/bash
# @file start.sh
# @brief Startup the complete environment.
#
# @description ...
#
# === Services
#
# ==== Docker Compose
# include::ROOT:partial$GENERATED/services-docker.adoc[]
#
# ==== Minikube
# include::ROOT:partial$GENERATED/services-k8s.adoc[]
#
# === Prerequisites
#
# A docker installation is needed to run minikube. To run all services from this stack Docker 23.0.5
# or greater is needed.
#
# To run minikube you'll need
#
# * 2 CPUs or more
# * 2GB of free memory
# * 20GB of free disk space
# * Internet connection
# * Container or virtual machine manager, such as: Docker, QEMU, Hyperkit, Hyper-V, KVM, Parallels, Podman, VirtualBox, or VMware Fusion/Workstation
#
# === Script Arguments
#
# The script does not accept any parameters.
#
# === Script Example
#
# [source, bash]
# ```
# ./start.sh
# ```
#
# === See also
#
# . Startup minikube: https://minikube.sigs.k8s.io/docs/start/


set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace


# Includes
source "lib/log.sh"


LOG_HEADER "Startup monitoring stack"
docker compose up -d

LOG_HEADER "Startup minikube"
minikube start --driver=docker

LOG_INFO "Enable addons"
minikube addons enable ingress
minikube addons enable metrics-server
minikube addons enable dashboard

LOG_HEADER "Wait for a moment to allow minikube to fully startup"
sleep 10

LOG_HEADER "Show addons"
minikube addons list

LOG_HEADER "Show versions"
LOG_INFO "minikube"
minikube version
LOG_INFO "kubectl"
kubectl version --output=yaml

LOG_HEADER "Show resources"
kubectl get po -A

LOG_HEADER "Show minikube status"
minikube status
