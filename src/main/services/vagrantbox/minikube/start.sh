#!/bin/bash
# @file install-minikube.sh
# @brief Provisioning script for Vagrantbox to start minikube inside the Vagrantbox.
#
# @description Start minikube inside the Vagrantbox.
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


LOG_HEADER_PLAIN "Start minikube cluster as user $(whoami)"
minikube start --driver=docker --force

LOG_HEADER_PLAIN "Show information from minikube and kubectl"
kubectl version
kubectl get po -A
