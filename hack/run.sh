#!/usr/bin/env bash

set -x

pushd .
# this should be run at the project dir
# cd ..

# up AGW VM
pushd .
cd lte/gateway
vagrant up magma
popd

# build orc8r containers
pushd .
cd orc8r/cloud/docker
python ./build.py -a  # default py 3.7.4
popd

## initial run ##
# build AGW from source
pushd .
vagrant ssh magma
cd magma/lte/gateway # MAGMA-VM
make run             # MAGMA-VM
popd

# start orc8r
docker-compose up -d
ls ../../../.cache/test_certs
open ../../../.cache/test_certs

# connect lte gw to local cloud !?
pushd .
cd lte/gateway
fab -f dev_tools.py register_vm
popd

vagrant ssh magma
sudo service magma@* stop         # MAGMA-VM
sudo service magma@magmad restart # MAGMA-VM
sudo tail -f /var/log/syslog      # MAGMA-VM

# nms ui
pushd .
cd nms/fbcnms-projects/magmalte
docker-compose build magmalte
docker-compose up -d
./scripts/dev_setup.sh
popd







