#!/bin/bash

set -e
set -x

SCRIPTFULL="$(readlink -f "$0")"
SETUPDIR="$(dirname "${SCRIPTFULL}")"

BASEDIR="/opt/vint"

mkdir -p "${BASEDIR}"
cd "${BASEDIR}"

apt-get -y -u install git build-essential gcc make wget libncurses-dev sharutils zip unzip telnet bc bison flex libssl-dev \
        simh \
        colossal-cave-adventure open-adventure bsdgames \
        fortunes fortune-mod fortunes-bofh-excuses

mkdir -p downloads
cd downloads

"${SETUPDIR}/download.sh"
sha256sum -c < "${SETUPDIR}/sums"
