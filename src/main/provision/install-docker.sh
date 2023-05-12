#!/bin/bash
# @file install-docker.sh
# @brief Provisioning script for Vagrantbox to install Docker into the Vagrantbox.
#
# @description Install Docker into the Vagrantbox.
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


LOG_HEADER_PLAIN "Install Docker"

LOG_INFO_PLAIN "Update the apt package index and install packages to allow apt to use a repository over HTTPS"
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg

LOG_INFO_PLAIN "Add Dockers official GPG key"
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

LOG_INFO_PLAIN "Set up the repository"
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

LOG_INFO_PLAIN "Install Docker Engine"
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

LOG_INFO_PLAIN "Add user to docker group"
sudo usermod -aG docker "vagrant"
sudo usermod -aG docker "$USER"
newgrp docker
