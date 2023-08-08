#!/bin/bash

set -e
set -x

dl () {
    if [ ! -f "`basename "$1"`" ]; then
        wget --no-verbose "$1"
    fi
}

dl http://fractal.math.unr.edu/~ejolson/pi/uudecode.c
dl http://fractal.math.unr.edu/~ejolson/pi/uuencode.c
dl http://www.columbia.edu/kermit/ftp/archives/ckc072.tar.gz
dl https://www.tuhs.org/Archive/Caldera-license.pdf
dl https://www.tuhs.org/Archive/Distributions/Boot_Images/2.11_on_Simh/211bsd.tar.gz
dl http://mirror.ifarchive.org/if-archive/games/source/dungn27s.zip
dl http://mirror.ifarchive.org/if-archive/games/source/dungn32b.zip
dl http://mirror.ifarchive.org/if-archive/games/source/dungeon-gdt-glk.tar.gz
dl https://eblong.com/zarf/glk/glkterm-104.tar.gz
wget --no-verbose --no-parent --mirror --recursive https://www.tuhs.org/Archive/Distributions/Research/Keith_Bostic_v7/
dl https://opensimh.org/research-unix-7-pdp11-45-v2.0.pdf

if [ ! -d devshane-zork ]; then
    git clone -n https://github.com/devshane/zork.git devshane-zork
fi
cd devshane-zork
git fetch
git checkout c44f046a1279c2d29ef3e46ec2e35d7aaecb580f
cd ..

# Data General

dl http://bitsavers.trailing-edge.com/pdf/dg/software/rdos/093-000109-01_RDOS_Command_Line_Interpreter.pdf
if [ ! -d wconrad.github.io ]; then
    git clone -n https://github.com/wconrad/wconrad.github.io.git
fi
cd wconrad.github.io
git fetch
git checkout 92d7797323b7347b073e9b6917f46458373a44b5
cd ..

# 8086 / DOS

if [ ! -d 8086tiny ]; then
    git clone -n https://github.com/adriancable/8086tiny.git
fi
cd 8086tiny
git fetch
git checkout c79ca2a34d96931d55ef724c815b289d0767ae3a
cd ..

# It takes a LONG time to build this stuff.  I've made a pre-built cache.
if [ ! -d its-built ]; then
    git clone --recurse-submodules -n https://github.com/jgoerzen/its-built.git
fi
cd its-built
git fetch
git checkout eec7197dc83bf56678b6c565e092225d103e3271
make submodules
cd ..


dl http://simh.trailing-edge.com/kits/rdosswre.tar.Z
dl http://simh.trailing-edge.com/kits/os8swre.tar.Z
dl http://simh.trailing-edge.com/kits/uv5swre.zip
dl http://simh.trailing-edge.com/kits/uv6swre.zip
dl http://simh.trailing-edge.com/kits/uv7swre.zip
dl http://simh.trailing-edge.com/kits/iu6swre.zip
dl http://simh.trailing-edge.com/kits/iu7swre.zip
dl http://pdp-10.trailing-edge.com/tapes/bb-d867e-bm_tops20_v41_2020_instl.tap.bz2
dl http://panda.trailing-edge.com/panda-dist.tar.gz
dl https://www.filfre.net/misc/TOPS-10.zip
dl https://www.wherry.com/gadgets/retrocomputing/vax-simh.html
dl http://mailman.trailing-edge.com/pipermail/simh/2006-November/000773.html
dl 'http://odl.sysworks.biz/disk$axpdocjun032/network/tcpip53/manage/6526pro_035.html'

find . -name .git -prune -o \( -type f -print0 \) | sort -z | xargs -0 sha256sum | grep -v newsums > ../newsums
echo "START OF NEW SUMS"
cat ../newsums
echo "END OF NEW SUMS"
