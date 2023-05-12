#!/bin/bash
# @file assert-is-vagrantbox.sh
# @brief Bash module which checks if the script (which includes this module) is invoked from inside the Vagrantbox.
#
# @description The script checks if the script (which includes this module) is invoked from inside
# the Vagrantbox. If assertion fails, the script is aborted.
#
# CAUTION: This script is a module an is not intended to run on its own. Include in script and
# use its functions!
#
# === Script Arguments
#
# The script does not accept any parameters.


set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace

readonly BOXNAME="k8s"
if [[ "$HOSTNAME" != "$BOXNAME" ]]; then
    LOG_ERROR "Hostname does not match $BOXNAME"
    LOG_ERROR "Connect using 'vagrant ssh' and run script inside Vagrantbox"
    exit 8
fi
