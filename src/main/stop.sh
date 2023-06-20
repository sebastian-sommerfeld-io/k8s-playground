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


# Download and include logging library
rm -rf /tmp/bash-lib
mkdir -p /tmp/bash-lib
curl -sL https://raw.githubusercontent.com/sebastian-sommerfeld-io/jarvis/main/src/main/modules/bash-script/assets/lib/log.sh --output /tmp/bash-lib/log.sh
source /tmp/bash-lib/log.sh


LOG_HEADER "Shutdown minikube"
minikube stop

LOG_HEADER "Shutdown monitoring stack"
docker compose down
