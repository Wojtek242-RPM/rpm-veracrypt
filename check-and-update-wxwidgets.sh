#!/usr/bin/env sh

set -e

SPEC_VERSION=`grep "%define wxwidgets_version" veracrypt.spec | cut -d " " -f 3`
REMOTE_VERSION=`git ls-remote --tags https://github.com/wxWidgets/wxWidgets.git | grep "refs/tags/v[0-9]\+.[0-9]\+.[0-9]\+$" | tail -n 1 | cut -d "/" -f 3 | sed -r 's/v(.*)/\1/'`

if [ "${SPEC_VERSION}" = "${REMOTE_VERSION}" ]
then
    echo "No new wxWidgets version : skipping update"
    exit 0
fi

echo "New wxWidgets version {${REMOTE_VERSION}} : updating"
sed -ri 's/Release:       ([0-9]+)%\{\?dist\}/echo "Release:       $((\1+1))%\{\?dist\}"/e' veracrypt.spec
sed -i "s/wxwidgets_version ${SPEC_VERSION}/wxwidgets_version ${REMOTE_VERSION}/" veracrypt.spec
