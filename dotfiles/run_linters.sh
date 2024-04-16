#!/bin/bash

# To be run from root dir. 
# This script will run yamllint and shfmt on the .devcontainer directory and log the output to a file.
# It will also run the super-linter on the root directory.

lint_log_dir="./lint_logs"
mkdir -p "$lint_log_dir"

# yamllint not found ... 
yamllint -s ./.github/ | tee "$lint_log_dir/yamllint.log"
shfmt -s -i 4 -d -w "$lint_log_dir/shfmt.diff" ./.devcontainer


# Run the super-linter on the root directory
# --rm removes the container afterwards 
docker run --rm \
    -e LOG_LEVEL=ERROR \
    -e RUN_LOCAL=true \
    -e CREATE_LOG_FILE=true \
    -e LOG_FILE=${lint_log_dir}/super-linter.log \
    -e DEFAULT_BRANCH=main \
    -e IGNORE_GITIGNORED_FILES=true \
    -e VALIDATE_SHELL_SHFMT=false \
    -e LINTER_RULES_PATH=./.github/linters \
    -e GITHUB_ACTIONS_COMMAND_ARGS="-ignore 'SC1090'" \
    -v ./:/tmp/lint \
    ghcr.io/super-linter/super-linter:slim-v6.3.1 \
   | tee ${lint_log_dir}/super-linter-summary.ans

    # ghcr.io/super-linter/super-linter:latest # if some of the non-slim ones are required

# chown to current user 
sudo chown --reference README.md ${lint_log_dir}/super-linter.log