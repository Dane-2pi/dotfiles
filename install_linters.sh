#!/bin/bash

#  Install a set of linters 

sudo apt-get install -y yamllint
curl -sS https://webinstall.dev/shfmt | bash
          source ~/.config/envman/PATH.env
docker pull github/super-linter:latest 
