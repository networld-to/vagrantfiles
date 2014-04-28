#!/usr/bin/env bash
source /usr/local/rvm/scripts/rvm
export DEBIAN_FRONTEND=noninteractive

rvm use --install $1

shift

if (( $# )); then
  gem install $@
fi
