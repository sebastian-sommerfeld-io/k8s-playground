#!/bin/bash
# @file start.sh
# @brief Provisioning script for Vagrantbox to startup the docker compose ops stack inside the Vagrantbox.
#
# @description Startup the docker compose ops stack inside the Vagrantbox. The ops stack exposes
# monitoring metrics and provices services to inspect the system.
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


LOG_HEADER_PLAIN "Startup the docker compose ops stack inside the Vagrantbox as user $(whoami)"
docker compose -f /vagrant/services/vagrantbox/ops/docker-compose.yml up -d
