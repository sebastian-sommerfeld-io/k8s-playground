#!/bin/bash
# @file stop.sh
# @brief Shutdown the complete environment.
#
# @description ...
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


LOG_HEADER "Shutdown minikube"
minikube stop

LOG_HEADER "Shutdown monitoring stack"
docker compose down
