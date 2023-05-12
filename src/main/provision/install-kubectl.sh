#!/bin/bash
# @file install-kubectl.sh
# @brief Provisioning script for Vagrantbox to install kubectl into the Vagrantbox.
#
# @description Install kubectl into the Vagrantbox.
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


LOG_HEADER_PLAIN "Install kubectl"
LOG_INFO_PLAIN "Download the latest release"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

LOG_INFO_PLAIN "Validate the binary"
curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check

LOG_INFO_PLAIN "Install"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
