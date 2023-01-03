#!/bin/bash

CWD="$(pwd)"
TEMP_DIR="/tmp"

apt-get update
DEBIAN_FRONTEND=noninteractive apt install -y --no-install-recommends wget bzip2 vim make binutils autoconf automake autotools-dev libtool python3-docutils ca-certificates pkg-config git curl dpkg-dev gcc-mingw-w64 g++-mingw-w64 autopoint libcppunit-dev libxml2-dev libgcrypt20-dev vim python-pip
pip install sphinx
git clone https://github.com/q3aql/aria2-static-builds.git
cd aria2-static-builds/build-scripts/mingw-config
git clone https://github.com/aria2/aria2.git
sed -i -e 's|/usr/i686|/usr/bin/i686|g' aria2-i686-w64-mingw-build-libs
sed -i -e 's|/usr/i686|/usr/bin/i686|g' aria2-i686-w64-mingw-config
./aria2-i686-w64-mingw-build-libs
cd aria2
cat NEWS | grep -m1 "" | awk "{print $2}" > /tmp/aria2.version
autoreconf -i
../aria2-i686-w64-mingw-config
make
strip --strip-all src/aria2c.exe
mkdir -p "${TEMP_DIR}/final_build"
echo "Storing artifact 'aria2c_mingw32.exe' to ${TEMP_DIR}/final_build"
cp src/aria2c.exe "${TEMP_DIR}/final_build/aria2c_mingw32.exe"
ls -lahtr "${TEMP_DIR}/final_build"

cd "${CWD}"
