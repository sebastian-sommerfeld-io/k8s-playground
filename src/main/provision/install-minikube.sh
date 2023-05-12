#!/bin/bash
# @file install-minikube.sh
# @brief Provisioning script for Vagrantbox to install minikube into the Vagrantbox.
#
# @description Install minikube into the Vagrantbox.
#
# CAUTION: This script is intended to run as part of the Vagrantbox provisioning. Do not run this
# script directly! Other files are referenced with a path that only exists inside the Vagrantbox.
# So running this script directly on your host would result in errors.
#
# === Script Arguments
#
# The script does not accept any parameters.


set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace


# Includes
source "/vagrant/lib/log.sh"


LOG_HEADER_PLAIN "Install latest stable release of minikube"
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
