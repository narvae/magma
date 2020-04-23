#!/usr/bin/env bash

set -x

pushd .
# this should be run at the project dir
# cd ..

# up AGW VM; tab 1
pushd .
cd lte/gateway
vagrant up magma
popd

# build orc8r containers; tab 2
pushd .
cd orc8r/cloud/docker
python ./build.py -a  # default py 3.7.4
popd

## initial run ##
# build AGW from source; tab 1
pushd .
cd lte/gateway
vagrant ssh magma
cd magma/lte/gateway # MAGMA-VM
make run             # MAGMA-VM
popd

# start orc8r; tab 2
pushd .
cd orc8r/cloud/docker
docker-compose up -d
ls ../../../.cache/test_certs
open ../../../.cache/test_certs
popd

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







