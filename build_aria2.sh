#!/bin/bash

apt-get update
apt install -y build-essential curl wget make git vim bash autoconf autopoint libtool pkg-config
cd aria2-static-builds/build-scripts/gnu-linux-config
git clone https://github.com/aria2/aria2.git
./aria2-x86_64-gnu-linux-build-libs
cd aria2
autoreconf -i
../aria2-x86_64-gnu-linux-config
make
