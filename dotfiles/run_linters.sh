#!/bin/bash

# To be run from root dir. 
# This script will run yamllint and shfmt on the .devcontainer directory and log the output to a file.
# It will also run the super-linter on the root directory.


yamllint -s ./.github/ | tee yamllint.log
shfmt -s -i 4 -d ./.devcontainer | tee shfmt.diff

docker run \
    -e RUN_LOCAL=true \
    -e USE_FIND_ALGORITHM=true \
    -e IGNORE_GITIGNORED_FILES=true \
    -e LINTER_RULES_PATH=./.github/linters \
    -e LOG_LEVEL=WARN \
    -e FILTER_REGEX_INCLUDE=.devcontainer* \
    -v ./:/tmp/lint \
    -w /tmp/lint \
    github/super-linter
