#!/bin/bash
# @file expose-dashboard.sh
# @brief Expose the Dashboard app.
#
# @description Minikube has integrated support for the
# link:https://github.com/kubernetes/dashboard[Kubernetes Dashboard UI]. The Dashboard is a
# web-based Kubernetes user interface. You can use it to:
#
# * deploy containerized applications to a Kubernetes cluster
# * troubleshoot your containerized application
# * manage the cluster resources
# * get an overview of applications running on your cluster
# * creating or modifying individual Kubernetes resources (such as Deployments, Jobs, DaemonSets, etc)
#
# For example, you can scale a Deployment, initiate a rolling update, restart a pod or deploy new
# applications using a deploy wizard.
#
# === Script Arguments
#
# The script does not accept any parameters.
#
# === Script Example
#
# [source, bash]
# ```
# ./expose-dashboard.sh
# ```
#
# === See Also
#
# . See https://minikube.sigs.k8s.io/docs/handbook/dashboard and https://minikube.sigs.k8s.io/docs/commands/dashboard
# for further information on how to use the Dashboard app with minikube.
# . For additional information, see
# link:https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard[the official Dashboard documentation].


set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace


# Includes
source "lib/log.sh"


LOG_HEADER "Expose dashboard app"
minikube dashboard --url --port=3999
