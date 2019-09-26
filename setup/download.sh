#!/bin/bash

set -e
set -x

dl () {
    if [ ! -f "`basename "$1"`" ]; then
        wget "$1"
    fi
}

dl https://www.tuhs.org/Archive/Caldera-license.pdf
dl https://www.tuhs.org/Archive/Distributions/Boot_Images/2.11_on_Simh/README.networked.211BSD
dl https://www.tuhs.org/Archive/Distributions/Boot_Images/2.11_on_Simh/211bsd.tar.gz
dl http://mirror.ifarchive.org/if-archive/games/source/dungn27s.zip
dl http://mirror.ifarchive.org/if-archive/games/source/dungn32b.zip
dl http://mirror.ifarchive.org/if-archive/games/source/dungeon-gdt-glk.tar.gz
dl http://eblong.com/zarf/glk/glkterm-104.tar.gz

git clone -n https://github.com/devshane/zork.git devshane-zork
cd devshane-zork
git checkout 95b1fd1feead1d52ce079678070f37daaf66766d
cd ..

find . -name .git -prune -o \( -type f -print0 \) | sort -z | xargs -0 sha256sum > newsums
