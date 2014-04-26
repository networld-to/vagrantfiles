#!/bin/bash
dummy_found=$(vagrant box list | grep dummy)

if [ "${dummy_found}" != "" ]; then
  echo "Box 'dummy' found!"
else
  vagrant box add dummy https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box
fi

vagrant up --provider=aws
