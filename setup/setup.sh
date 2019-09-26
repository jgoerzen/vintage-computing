#!/bin/bash

set -e
set -x
set -o pipefail

SCRIPTFULL="$(readlink -f "$0")"
SETUPDIR="$(dirname "${SCRIPTFULL}")"

BASEDIR="/opt/vint"

mkdir -p "${BASEDIR}"
cd "${BASEDIR}"

mkdir -p downloads
cd downloads

"${SETUPDIR}/instpkgs.sh"
"${SETUPDIR}/download.sh"
sha256sum -c < "${SETUPDIR}/sums"

cd "${BASEDIR}"
cp -r "${SETUPDIR}/systems.skel" systems

#### zork-glk

cd "${BASEDIR}/systems"
mkdir -p zork-glk/files
cd zork-glk/files
mkdir dungn27s
cd dungn27s
unzip -L "${BASEDIR}/downloads/dungn27s.zip"
cd ..
mkdir dungn32b
cd dungn32b
unzip -L "${BASEDIR}/downloads/dungn32b.zip"
cd ..
tar -zxvf "${BASEDIR}/downloads/dungeon-gdt-glk.tar.gz"
tar -zxvf "${BASEDIR}/downloads/glkterm-104.tar.gz"
cd glkterm
make
cd ../dungeon-gdt
sed -i "s,^DATADIR.*,DATADIR=`pwd`," Makefile
make

#### main zork

cd "${BASEDIR}/systems"
mkdir -p zork-old
cd zork-old
cp -r "${BASEDIR}/downloads/devshane-zork" files
cd files
sed -i "s,^DATADIR.*,DATADIR=`pwd`," Makefile
make

cp "${SETUPDIR}/vint" "/usr/local/bin"

### pdp11-2bsd

cd "${BASEDIR}/systems"
mkdir -p pdp11-2bsd
cd pdp11-2bsd
tar -zxvf "${BASEDIR}/downloads/211bsd.tar.gz"
mv 211bsd files

### nova-rdos

cd "${BASEDIR}/systems"
mkdir -p nova-rdos
cd nova-rdos
ln ../../downloads/093-000109-01_RDOS_Command_Line_Interpreter.pdf
ln ../../downloads/wconrad.github.io/_posts/2015-12-07-simh-nova-hello-world.markdown
mkdir -p files
cd files
tar -xvf "${BASEDIR}/downloads/rdosswre.tar.Z"

### pdp10-tops10
cd "${BASEDIR}/systems"
mkdir -p pdp10-tops10/files
cd pdp10-tops10/files
unzip "${BASEDIR}/downloads/TOPS-10.zip"

### pdp10-tops20-panda
# http://panda.trailing-edge.com/
# https://www.ldx.ca/notes/tops-20-notes.html
cd "${BASEDIR}/systems"
mkdir -p pdp10-tops20-panda
cd pdp10-tops20-panda
tar -zxvf "${BASEDIR}/downloads/panda-dist.tar.gz"
mv -vi panda-dist files


### pdp10-tops20
# From http://gunkies.org/wiki/Running_TOPS-20_V4.1_under_SIMH
cd "${BASEDIR}/systems"
mkdir -p pdp10-tops20/files
cd pdp10-tops20/files
bzcat "${BASEDIR}/downloads/bb-d867e-bm_tops20_v41_2020_instl.tap.bz2" > i.tap
./bootstrap.expect | tee bootstrap.log
