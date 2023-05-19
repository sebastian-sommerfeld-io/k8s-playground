#!/bin/bash
# @file generate-docs.sh
# @brief Auto-generate docs based on Docker Compose config, Minikube config and Terraform config.
#
# @description The script auto-generates docs based on Docker Compose config, Minikube config and
# Terraform config. All generated files are Asciidoc and sorted into this repos docs (see folder
# ``docs/modules/AUTO-GENERATED/pages``).
#
# NOTE: When calling this script from the ``.github/workflows/auto-generate-docs.yml`` workflow,
# make sure you create the bash-docs first.
#
# === Script Arguments
#
# The script does not accept any parameters.
#
# === Script Example
#
# [source, bash]
# ```
# ./generate-docs.sh
# ```


set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace


# Includes
source "../main/lib/log.sh"


# @description Wrapper function to encapsulate yq in a docker container using the 
# link:https://hub.docker.com/r/mikefarah/yq[mikefarah/yq] image.
#
# The current working directory is mounted into the container and selected as working directory so that
# all file of the project are available. Paths are preserved.
#
# @example
#    yq --version
#
# @arg $@ String The yq query (1-n arguments) - $1 is mandatory
#
# @exitcode 8 If param with query is missing
function yq() {
    if [ -z "$1" ]; then
        echo -e "$LOG_ERROR No query passed to the yq container"
        echo -e "$LOG_ERROR exit" && exit 8
    fi

    docker run -it --rm \
        --volume "$(pwd):$(pwd)" \
        --workdir "$(pwd)" \
        mikefarah/yq:4.33.3 "$@"
}


LOG_HEADER "Generate docs"
(
    cd ../../ || exit
    LOG_INFO "Working from $(pwd)"
    ls -alF
    whoami

    readonly TARGET_BASE_PATH="docs/modules/AUTO-GENERATED/partials/environment"
    LOG_INFO "Create target directory"
    mkdir -p "$(pwd)/$TARGET_BASE_PATH"
    
    readonly COMPOSE_FILE="src/main/docker-compose.yml"
    readonly TARGET_ADOC_FILE="$TARGET_BASE_PATH/services-docker-table-body.adoc"
    
    LOG_INFO "Generate docs from $COMPOSE_FILE"
    yq eval '.services.[] | "|" + .container_name + " |" + .image' "$COMPOSE_FILE" > "$TARGET_ADOC_FILE"
)
