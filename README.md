# Vintage Computing for Docker, Raspberry Pi, and Debign

This repository provides vintage emulators and games for Docker,
Raspberry Pi, and Debian systems in general.  Included are such things
as a PDP-11 emulation, Zork/Dungeon, Colossal Cave Adventure, and
other legendary programs.

# Basic Use

A command `vint` is provided in `/usr/local/bin` to run the included
programs.  None of them should be run as root, so if `vint` is run as
root, it will instead run the programs as the user `pi` (which is
created for you in Docker, or on Raspbian; on Debian, you're on your
own.)

# Use in Docker

You can run `docker run -ti jgoerzen/vintage-computing vint` (with
whatever parameters you need) to just fire up something in your
terminal.  The image is also based on my [Debian base
images](https://github.com/jgoerzen/docker-debian-base), so you could
also configure SSH or other access to the system if you so desire.

The Docker image intentionally leaves build files and downloads
sitting around; these are important for posterity and the files that
go into this system are somewhat rare.  They often contain
documentation and such as well.

# Use in Raspbian (Raspberry Pi) or Debian

A buster-based distribution is required.

Run:

```
git clone https://github.com/jgoerzen/vintage-computing
cd vintage-computing/setup
sudo ./setup.sh
sudo chown -R "`id -u`:`id -g`" /opt/vint
```

# Documentation & Info

The directory `/opt/vint/systems` will contain information for most
systems included here, particularly inside the `files` directory.

You may see files ending with a number; for instance, `foo.1` -- or
maybe `foo.1.gz`.  In
those cases, you can display the documentation with a command like
`man -l foo.1` or `man -l foo.1.gz`.

Docker users may wish to make volumes out of /home/pi (to persist
savegames and the like) or parts of `/opt/vint/systems` to make
emulator images and such persistent.

The setup scripts to generate all this are in `/opt/vint/setup`.
These document the sources for the code and steps taken to install it
all.

# Included Games

## Colossal Cave Adventure

This is the text adventure that started it all: [Colossal Cave
Adventure](https://en.wikipedia.org/wiki/Colossal_Cave_Adventure) by
Crowther & Woods, also known as adventure and advent.

I have provided three versions for you:

 - `vint colossal-cave-adventure` is the one I recommend.  It is a faithful
   port of the canonical 350-point version, usies the original text
   exactly, and even simulates the speed of the terminals in use in
   the era in which it was written.
 - `vint bsd-adventure` is the version distributed by BSD distributions (and
   Debian in bsdgames), which was an early port to C by Jim Gillogly.
 - `vint open-adventure` is a port of the last version that Crowther & Woods
   themselves released.

## Zork (aka Dungeon)

This is the other famous text adventure,
[Zork](https://en.wikipedia.org/wiki/Zork).  As with Adventure, there
are [many versions](http://gunkies.org/wiki/Zork) of Zork out there,
and even a [history of Zork](http://gunkies.org/wiki/History_of_Zork)
is available.

The Zorks I provide here are based on the monolithic Zorks, before the
game was split into three parts for PC distribution.  Three Zorks are
provided:

- `vint zork-glk` is a good version, updated with somewhat modern
  terminal handling.  It is the version that FreeBSD uses in their
  ports collection.  `history` says it is 3.2A.
- `vint zork-old` is the original C port.  `history` says version 2.7.
- The included `pdp11-2bsd` environment (see below) has a zork that
  can be invoked at `/usr/games/zork` once you are in the
  environment.  saved and restore are buggy in this game, however, and
  are not recommended.  (This is not a bug in the emulator, but the
  original program!)  `history` says version 2.0a.

## Fortune

The `vint fortune` command will display a random fortune from the
included database, which is part of Debian.  Many users used to put
this in their login scripts to automatically display a random little
snippet when they'd log in.

# Included Emulators

## PDP-11 with 2BSD 2.11

The machine that started it all... or at least, uh, lots.  `vint
pdp11-2bsd` will fire up the SIMH emulator of a PDP-11 running 2BSD
version 2.11.  Please note that this system doesn't automatically
boot, but needs a bit of help to get to a login prompt.  The
instructions for doing so are displayed on your screen as the
simulator starts.

# Source

This is prepared by John Goerzen <jgoerzen@complete.org> and the source
can be found at https://github.com/jgoerzen/vintage-computing

# Copyright

Docker scripts, etc. are Copyright (c) 2019 John Goerzen.  
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions
are met:
1. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.
3. Neither the name of the University nor the names of its contributors
   may be used to endorse or promote products derived from this software
   without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE AUTHORS AND CONTRIBUTORS ``AS IS'' AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
SUCH DAMAGE.

Additional software copyrights as noted.

