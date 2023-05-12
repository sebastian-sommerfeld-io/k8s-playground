#!/bin/bash
# @file destroy.sh
# @brief Shutdown and destroy the complete environment.
#
# @description ...
#
# === Script Arguments
#
# The script does not accept any parameters.
#
# === Script Example
#
# [source, bash]
# ```
# ./destroy.sh
# ```


set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace


# Includes
source "lib/log.sh"


LOG_INFO "Shutdown and destroy the complete environment"

LOG_HEADER "Shutdown and destroy monitoring stack"
(
    cd services/host/monitoring || exit
    docker compose down -v --rmi all
)

LOG_HEADER "Shutdown and destroy Vagrantbox which is running minikube"
vagrant halt
vagrant destroy -f
