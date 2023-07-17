#!/bin/bash
# @file install.sh
# @brief Install minikube and tools.
#
# @description Install minikube and tools like kubectl. Minikube is local Kubernetes, focusing on making it
# easy to learn and develop for Kubernetes.
#
# === Script Arguments
#
# The script does not accept any parameters.
#
# == See Also
#
# . Stackoverflow: link:https://stackoverflow.com/questions/57821066/how-to-update-minikube-latest-version[How to update minikube latest version]
#
# == Prerequisites
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



set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace


# Download and include logging library
rm -rf /tmp/bash-lib
mkdir -p /tmp/bash-lib
curl -sL https://raw.githubusercontent.com/sebastian-sommerfeld-io/jarvis/main/src/main/modules/bash-script/assets/lib/log.sh --output /tmp/bash-lib/log.sh
source /tmp/bash-lib/log.sh


readonly MINIKUBE_VERSION="v1.30.1"


LOG_HEADER "Install kubectl"
LOG_INFO "Download latest release"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

LOG_INFO "Validate kubectl binary"
curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check

LOG_INFO "Install"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm kubectl.sha256
rm kubectl

LOG_HEADER "Install minikube $MINIKUBE_VERSION"
curl -LO https://github.com/kubernetes/minikube/releases/download/$MINIKUBE_VERSION/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
rm minikube-linux-amd64
