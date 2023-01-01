#!/bin/bash

CWD="$(pwd)"
TEMP_DIR="/tmp"

apt-get update
DEBIAN_FRONTEND=noninteractive apt install -y --no-install-recommends ca-certificates build-essential curl wget make git vim bash autoconf autopoint libtool pkg-config docutils
git clone https://github.com/q3aql/aria2-static-builds.git
cd aria2-static-builds/build-scripts/gnu-linux-config
git clone https://github.com/aria2/aria2.git
./aria2-x86_64-gnu-linux-build-libs
cd aria2
autoreconf -i
../aria2-x86_64-gnu-linux-config
make
strip --strip-all src/aria2c
mkdir -p "${TEMP_DIR}/final_build"
echo "Storing artifact 'aria2c_amd64' to ${TEMP_DIR}/final_build"
cp src/aria2c "${TEMP_DIR}/final_build/aria2c_amd64"
ls -lahtr "${TEMP_DIR}/final_build"

cd "${CWD}"
