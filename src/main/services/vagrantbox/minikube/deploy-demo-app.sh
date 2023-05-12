#!/bin/bash
# @file deploy-demo-app.sh
# @brief Provisioning script for Vagrantbox to deploy and run a demo webapp in minikube.
#
# @description Deploy and run a demo webapp in minikube.
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


LOG_HEADER_PLAIN "Create a sample deployment"

kubectl create deployment hello-minikube --image=kicbase/echo-server:1.0
kubectl expose deployment hello-minikube --type=NodePort --port=8080

sleep 30

# kubectl port-forward service/hello-minikube 6080:8080

kubectl get po -A
kubectl get services hello-minikube