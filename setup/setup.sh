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

cd /tmp
mkdir -p /usr/local/python
PIPX_BIN_DIR=/usr/local/bin PIPX_HOME=/usr/local/python pipx install --system-site-packages pcbasic

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
cp -rs "${BASEDIR}/downloads/devshane-zork" files
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

### pdp11-unixv5

cd "${BASEDIR}/systems"
mkdir -p pdp11-unixv5
cd pdp11-unixv5/files
unzip "${BASEDIR}/downloads/uv5swre.zip"

### pdp11-unixv6

cd "${BASEDIR}/systems"
mkdir -p pdp11-unixv6
cd pdp11-unixv6/files
unzip "${BASEDIR}/downloads/uv6swre.zip"

### pdp11-unixv5

cd "${BASEDIR}/systems"
mkdir -p pdp11-unixv7
cd pdp11-unixv7/files
mkdir v7-work
#cp ${BASEDIR}/downloads/www.tuhs.org/Archive/Distributions/Research/Keith_Bostic_v7/*.{pl,gz} .
#chmod u+x mktape.pl
#gunzip f?.gz
#./mktape.pl
zcat ${BASEDIR}/downloads/www.tuhs.org/Archive/Distributions/Research/Keith_Bostic_v7/v7.tap.gz > v7.tap
sha1sum v7.tap | grep e6188335c0c9a3e3fbdc9c29615f940233722432
#rm f* mktape.pl
ls -l
./tapeboot.expect

cd ..
mkdir v7-saved-environments
tar -cvjf v7-saved-environments/v7-pristine.tar.bz2 v7-work
ls -lh v7-saved-environments
cd v7-work
./nboot-expect
cd ..
tar -cvjf v7-saved-environments/v7-multi-user.tar.bz2 v7-work
ls -lh v7-saved-environments

cd v7-work
./multisess.expect



unzip "${BASEDIR}/downloads/uv7swre.zip"

### interdata-unixv6

cd "${BASEDIR}/systems"
mkdir -p interdata-unixv6
cd interdata-unixv6/files
unzip "${BASEDIR}/downloads/iu6swre.zip"

### interdata-unixv7

cd "${BASEDIR}/systems"
mkdir -p interdata-unixv7
cd interdata-unixv7/files
unzip "${BASEDIR}/downloads/iu7swre.zip"

### nova-rdos

cd "${BASEDIR}/systems"
mkdir -p nova-rdos
cd nova-rdos
ln ../../downloads/093-000109-01_RDOS_Command_Line_Interpreter.pdf
ln ../../downloads/wconrad.github.io/_posts/2015-12-07-simh-nova-hello-world.markdown
mkdir -p files
cd files
tar -xvf "${BASEDIR}/downloads/rdosswre.tar.Z"

### 8086tiny / DOS

cd "${BASEDIR}/systems"
mkdir -p dos-8086tiny
cd dos-8086tiny
cp -rs "${BASEDIR}/downloads/8086tiny" files
cd files
make no_graphics

### pdp10-its

cd "${BASEDIR}/systems"
mkdir -p pdp10-its
cd pdp10-its
cp -r "${BASEDIR}/downloads/its-built" files
cd files/out/simh
gunzip *.gz
cd ../..
# Build all the stuff that doesn't need an image
make EMULATOR=simh EXPECT=true

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

cd "${BASEDIR}"
find . -type d -name .git -exec rm -r {} +

# Make sure we still have the right sums
cd "${BASEDIR}/downloads"
sha256sum -c < "${SETUPDIR}/sums"


echo " ************************"
echo " Setup process successful"
echo " ************************"
