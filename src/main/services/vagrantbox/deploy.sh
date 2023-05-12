#!/bin/bash
# @file deploy.sh
# @brief Deploy apps to kubernetes.
#
# @description ...
#
# NOTE: This script is intended to run inside the Vagrantbox, so first connect with ``vagrant ssh``.
# Then navigate to ``/vagrant/services/vagrantbox`` folder and run the script from there.
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
source "../../lib/log.sh"
source "../../lib/assert-is-vagrantbox.sh"


LOG_HEADER "Deploy app to kubernetes"
(
    cd minikube/apps || exit

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
