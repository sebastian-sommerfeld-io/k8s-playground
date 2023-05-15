#!/bin/bash
# @file deploy.sh
# @brief Deploy apps to kubernetes.
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
# ./deploy.sh
# ```


set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace


# Includes
source "lib/log.sh"


LOG_HEADER "Deploy app to kubernetes"
(
    cd apps || exit

    echo -e "$LOG_INFO Select app for deployment"
    select a in */; do
        readonly APP="${a::-1}"

        LOG_INFO "Deploy $APP"
        kubectl apply -f "$APP/deployment.yml"
        kubectl apply -f "$APP/service.yml"

        kubectl get pods
        break
    done
)
