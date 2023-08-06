#!/bin/bash
set -e
set -x

apt-get update
apt-get  -y -u install git gcc make wget libncurses-dev sharutils zip unzip telnet bc bison flex libssl-dev sudo python3-pexpect \
        expect libpcap-dev libvdeplug-dev bzip2 \
        simh \
        colossal-cave-adventure open-adventure bsdgames \
        fortunes fortune-mod fortunes-bofh-excuses figlet sysvbanner bsdmainutils gopher alpine ftp telnet \
        cowsay moon-buggy asciijump pacman4console sl petris \
        jzip frotz fizmo-console
apt-get -y -u --no-install-recommends install pipx
