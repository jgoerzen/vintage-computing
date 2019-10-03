#!/bin/bash

set -e
set -x

dl () {
    if [ ! -f "`basename "$1"`" ]; then
        wget --no-verbose "$1"
    fi
}

dl https://www.tuhs.org/Archive/Caldera-license.pdf
dl https://www.tuhs.org/Archive/Distributions/Boot_Images/2.11_on_Simh/211bsd.tar.gz
dl http://mirror.ifarchive.org/if-archive/games/source/dungn27s.zip
dl http://mirror.ifarchive.org/if-archive/games/source/dungn32b.zip
dl http://mirror.ifarchive.org/if-archive/games/source/dungeon-gdt-glk.tar.gz
dl https://eblong.com/zarf/glk/glkterm-104.tar.gz

if [ ! -d devshane-zork ]; then
    git clone -n https://github.com/devshane/zork.git devshane-zork
    cd devshane-zork
    git checkout 95b1fd1feead1d52ce079678070f37daaf66766d
    cd ..
fi

# Data General

dl http://bitsavers.trailing-edge.com/pdf/dg/software/rdos/093-000109-01_RDOS_Command_Line_Interpreter.pdf
if [ ! -d wconrad.github.io ]; then
    git clone -n https://github.com/wconrad/wconrad.github.io.git
    cd wconrad.github.io
    git checkout 92d7797323b7347b073e9b6917f46458373a44b5
    cd ..
fi

# 8086 / DOS

if [ ! -d 8086tiny ]; then
    git clone -n https://github.com/adriancable/8086tiny.git
    cd 8086tiny
    git checkout c79ca2a34d96931d55ef724c815b289d0767ae3a
    cd ..
fi

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
dl http://www.itec.suny.edu/scsys/vms/OVMSDOC073/V73/6526/6526pro_035.html

cd ..
find . -name .git -prune -o \( -type f -print0 \) | sort -z | xargs -0 sha256sum | grep -v newsums > newsums
