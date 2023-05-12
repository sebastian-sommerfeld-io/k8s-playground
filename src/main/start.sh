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


set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace


# Includes
source "lib/log.sh"


LOG_INFO "Startup the complete environment"

LOG_HEADER "Startup monitoring stack"
(
    cd services/host/monitoring || exit
    docker compose up -d
)

LOG_HEADER "Startup Vagrantbox which is running minikube"
vagrant up
