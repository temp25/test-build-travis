#!/bin/bash

apt-get update
apt install -y build-essential curl wget make git vim bash autoconf autopoint libtool pkg-config docutils
git clone https://github.com/q3aql/aria2-static-builds.git
cd aria2-static-builds/build-scripts/gnu-linux-config
git clone https://github.com/aria2/aria2.git
./aria2-x86_64-gnu-linux-build-libs
cd aria2
autoreconf -i
../aria2-x86_64-gnu-linux-config
make
strip --strip-all src/aria2c
cp src/aria2c $HOME/final_build/
ls -lahtr $HOME/final_build
