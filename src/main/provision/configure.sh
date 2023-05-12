#!/bin/bash
# @file configure.sh
# @brief Provisioning script for Vagrantbox to apply basic configuration.
#
# @description The scripts adds settings to the ``~/.bashrc`` file of the user "vagrant".
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

export home="/home/vagrant"


LOG_HEADER_PLAIN "Configure"


LOG_INFO_PLAIN "Update bash prompt"
bashrc="$home/.bashrc"
promptDefinition="\${debian_chroot:+(\$debian_chroot)}\[\033[01;33m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] \$ "
grep -qxF "export PS1='${promptDefinition}'" "$bashrc" || echo "export PS1='${promptDefinition}'" >>"$bashrc"


LOG_INFO_PLAIN "Write aliases to .bashrc file"
aliases=(
  'alias ll="ls -alFh --color=auto"'
  'alias ls="ls -a --color=auto"'
  'alias grep="grep --color=auto"'
)
for alias in "${aliases[@]}"; do
  grep -qxF "$alias" "$bashrc" || echo "$alias" >> "$bashrc"
done
