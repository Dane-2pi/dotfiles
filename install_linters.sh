#!/bin/bash

Workspace_Dir='/workspaces/'${RepositoryName}

LOG_FILE=$Workspace_Dir'/.dotfiles/install_log.txt'

echo "Installing linters "  >> $LOG_FILE

sudo apt-get update

sudo apt-get install -y yamllint
curl -sS https://webinstall.dev/shfmt | bash
          source ~/.config/envman/PATH.env
# docker pull github/super-linter:latest 

echo "Checking if linters are installed"  >> $LOG_FILE
yamllint --version >> $LOG_FILE
shfmt --version >> $LOG_FILE


#  To run  them  :
# bash ./.dotfiles/run_linters.sh