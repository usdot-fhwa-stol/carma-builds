#!/bin/sh

set -ex

cat <<EOF >/etc/apt/sources.list.d/ubuntu-$(lsb_release -cs)-ports.list
deb [arch=armhf] http://ports.ubuntu.com/ubuntu-ports/ $(lsb_release -cs) main restricted universe multiverse
deb [arch=armhf] http://ports.ubuntu.com/ubuntu-ports/ $(lsb_release -cs)-updates main restricted universe multiverse
EOF
