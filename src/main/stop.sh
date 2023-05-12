#!/bin/bash
# @file stop.sh
# @brief Shutdown the complete environment and cleanup afterwards.
#
# @description Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. 
#
# === Script Arguments
#
# The script does not accept any parameters.
# * *$1* (string): Some var
#
# === Script Example
#
# [source, bash]
# ```
# ./stop.sh
# ```


set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace


# Includes
source "lib/log.sh"


LOG_INFO "Shutdown the complete environment"

LOG_HEADER "Shutdown monitoring stack"
(
    cd services/host/monitoring || exit
    docker compose down -v --rmi all
)

LOG_HEADER "Shutdown Vagrantbox which is running minikube"
vagrant halt
vagrant destroy -f
