#!/bin/bash

set -e
set -x

dl () {
    if [ ! -f "$1" ]; then
        wget "$1"
    fi
}

dl https://www.tuhs.org/Archive/Caldera-license.pdf
dl https://www.tuhs.org/Archive/Distributions/Boot_Images/2.11_on_Simh/README.networked.211BSD
dl https://www.tuhs.org/Archive/Distributions/Boot_Images/2.11_on_Simh/211bsd.tar.gz

git clone -n https://github.com/devshane/zork.git devshane-zork
cd devshane-zork
git checkout 95b1fd1feead1d52ce079678070f37daaf66766d
cd ..

