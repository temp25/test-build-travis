#!/bin/bash

ARIA2_VERSION_FILE="/tmp/aria2.version"
ARTIFACT_NAME="$1"

if [ $# -ne 1 ]; then
  echo "ERROR: Please pass artifact name as first argument."
  exit 1
fi

apt-get update
apt install -y python-pip
which pip > /dev/null
if [ $? -ne 0 ]; then
  ln -s $(which pip2) /usr/bin/pip
fi

pip install --upgrade cloudsmith-cli
cloudsmith --version

if [ $? -ne 0 ]; then
  echo "ERROR: Unable to retrieve cloudsmith version"
  exit 2
fi

if [ ! -f "${ARIA2_VERSION_FILE}" ]; then
  echo "ERROR: Aria2 version file not found"
  exit 3
fi

if [ -z "${CLOUDSMITH_API_KEY}" ]; then
  echo "ERROR: Environment variable 'CLOUDSMITH_API_KEY', not set. Cannot proceed with artifact upload to cloudsmith repository."
  exit 4
fi

if [ -z "${CLOUDSMITH_OWNER_REPO}" ]; then
  echo "ERROR: Environment variable 'CLOUDSMITH_OWNER_REPO', not set. Cannot proceed with artifact upload to cloudsmith repository."
  exit 5
fi

export ARIA2_VERSION=$(cat "${ARIA2_VERSION_FILE}")

cloudsmith push raw --verbose --version "${ARIA2_VERSION}" --api-key "${CLOUDSMITH_API_KEY}" "${CLOUDSMITH_OWNER_REPO}" "/tmp/final_build/${ARTIFACT_NAME}"

rm -rf "${ARIA2_VERSION_FILE}"

