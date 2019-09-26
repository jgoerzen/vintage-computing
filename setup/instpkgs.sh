#!/bin/bash
set -e
set -x

apt-get update
apt-get -y -u install git gcc make wget libncurses-dev sharutils zip unzip telnet bc bison flex libssl-dev sudo \
        simh \
        colossal-cave-adventure open-adventure bsdgames \
        fortunes fortune-mod fortunes-bofh-excuses

