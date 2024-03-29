#!/usr/bin/env sh

set -e

SPEC_VERSION=`grep "%define veracrypt_version" veracrypt.spec | cut -d " " -f 3`
REMOTE_VERSION=`git ls-remote --tags https://github.com/veracrypt/VeraCrypt.git | grep "refs/tags/VeraCrypt_1" | tail -n 1 | cut -d "/" -f 3 | sed -r 's/VeraCrypt_(.*)/\1/'`

if [ "${SPEC_VERSION}" = "${REMOTE_VERSION}" ]
then
    echo "No new VeraCrypt version : skipping update"
    exit 0
fi

echo "New VeraCrypt version {${REMOTE_VERSION}} : updating"
sed -ri "s/Release:       [0-9]+%\{\?dist\}/Release:       1%\{\?dist\}/" veracrypt.spec
sed -i "s/veracrypt_version ${SPEC_VERSION}/veracrypt_version ${REMOTE_VERSION}/" veracrypt.spec
