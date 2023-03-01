#!/bin/sh

set -ex

echo "BUILD_ARCHITECTURE=${BUILD_ARCHITECTURE}"
cat <<EOF >/etc/apt/sources.list.d/ubuntu-$(lsb_release -cs)-ports.list
deb [arch=${BUILD_ARCHITECTURE}] http://ports.ubuntu.com/ubuntu-ports/ $(lsb_release -cs) main restricted universe multiverse
deb [arch=${BUILD_ARCHITECTURE}] http://ports.ubuntu.com/ubuntu-ports/ $(lsb_release -cs)-updates main restricted universe multiverse
EOF
