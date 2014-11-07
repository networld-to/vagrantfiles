#!/usr/bin/env bash

rvm_installed=$(rvm --version &> /dev/null; echo $?)

if ! [ ${rvm_installed} == 0 ]; then
  gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
  export DEBIAN_FRONTEND=noninteractive
  curl -sSL https://get.rvm.io | bash -s $1
else
  echo "Skipping rvm installation! rvm command found"
fi
