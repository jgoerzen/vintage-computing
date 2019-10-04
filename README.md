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

Within the Docker image, at any shell prompt, just run `vint` as in
the examples below.

The Docker image intentionally leaves build files and downloads
sitting around; these are important for posterity and the files that
go into this system are somewhat rare.  They often contain
documentation and such as well.

# Use in Raspbian (Raspberry Pi) or Debian

A buster-based distribution is required.

To install, run:

```
git clone https://github.com/jgoerzen/vintage-computing
cd vintage-computing/setup
sudo ./setup.sh
sudo chown -R "`id -u`:`id -g`" /opt/vint
```

To launch programs, just type `vint` with whatever parameters are
needed (as shown below).

# Documentation & Info

The directory `/opt/vint/systems` will contain information for most
systems included here, particularly inside the `files` directory.

You may see files ending with a number; for instance, `foo.1` -- or
maybe `foo.1.gz`.  In those cases, you can display the documentation
with a command like `man -l foo.1` or `man -l foo.1.gz`.

Many programs also have system manpages; for instance, `man figlet`
will show the system's documentation for figlet.

Docker users may wish to make volumes out of /home/pi (to persist
savegames and the like) or parts of `/opt/vint/systems` to make
emulator images and such persistent.

Much documentation also exists in `/usr/share/doc`.

Many of these packages are based on SIMH.  The [SIMH
website](http://simh.trailing-edge.com/) and `/usr/share/doc/simh`
contain a wealth of information.  The [sample software
documentation](http://simh.trailing-edge.com/pdf/simh_swre.pdf), also
available in `/usr/share/doc/simh`, describes loading and working with
some of these systems.

In Docker, the setup scripts to generate all this are in
`/opt/vint/setup`.  (For Raspberry Pi and local installations, this
repository has the same files.)  These document the sources for the
code and steps taken to install it all.

# Included Games

## Colossal Cave Adventure

This is the text adventure that started it all: [Colossal Cave
Adventure](https://en.wikipedia.org/wiki/Colossal_Cave_Adventure) by
Crowther & Woods, also known as adventure and advent.

I have provided five versions for you:

 - `vint colossal-cave-adventure` is the one I recommend.  It is a faithful
   port of the canonical 350-point version, usies the original text
   exactly, and even simulates the speed of the terminals in use in
   the era in which it was written.
 - `vint bsd-adventure` is the version distributed by BSD distributions (and
   Debian in bsdgames), which was an early port to C by Jim Gillogly.
 - `vint open-adventure` is a port of the last version that Crowther & Woods
   themselves released.
 - Two versions are also included in the PDP-10 TOPS-10 installation;
   see rhe linked readme in that section for details.

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

## Figlet

The `vint figlet` command will render text in large blocks.  For
instance, `vint figlet xyzzy` displays:

```
                          __  ___   _ _________   _ 
                          \ \/ / | | |_  /_  / | | |
                           >  <| |_| |/ / / /| |_| |
                          /_/\_\\__, /___/___|\__, |
                                |___/         |___/ 
```

## Banner

There are two banner-type programs installed:

 - `vint banner` will generate horizontal ASCII-art banners.  It comes
   from the Debian package sysvbanner.
 - `vint printerbanner` will generate vertical (rotated) ASCII-art
   banners.  It comes from the Debian package bsdmainutils.

## Debian and BSD games (/usr/games) (more than 50)

In addition to the games listed above, quite a few more (over 60!) are
also available in `/usr/games`.  These are installed via Debian
packages, are all open source.  Most come from the `bsdgames`
collection.  Some were written decades ago, though a few are more
modern.  All can be played on a text terminal.  A few of these can
also be launched by other commands documented above.

To get a list of available games, type `vint usrgames list`.  The list
is large, so you may want to pipe it through a pager like `vint
usrgames list | less`

Here are some highlights for you:

 - `tetris-bsd` and `petris` are Tetris implementations
 - `moon-buggy` is an implementation of the well-known lunar lander
   games
 - `snake` is a growing snake game
 - `sl` draws animated steam locomotives
 - `cowsay` renders text as if quoted by a cow.  (See also figlet
   above)
   
## Z-Machine (Z-Code) Interpreters

Many text adventure games have been written to target the z-machine
(zcode) environment.  They often end with extensions like `.z5` or
similar.  You can get them from the [Interactive Fiction
Archive](http://ifarchive.org/), which has a large [collection of
zcode games](http://ifarchive.org/indexes/if-archive/games/zcode/).
The [IFDB](http://ifdb.tads.org/) has references to even more.  Some
of the most famous games were released as zcode (for instance, Zork
I - III).

You will need to download your own z-machine games, but once you have
them, there are several interpreters available:

 - frotz is the one I generally recommend.  Launch games with `vint
   usrgames frotz gamename`
 - jzip is also available.  Use `vint usrgames jzip gamename`
 - fizmo is also available. Use `vint usrgames fizmo-console gamename`

# Included Tools

## Gopher

After FTP, but before there was the web, there was gopher - the
hypertext system from the University of Minnesota.  The UMN gopher
client is included, which can be used to browse some of the
still-existing gopher servers.

Use `vint gopher`

# Included Emulators

## PDP-11 with 2BSD 2.11

The machine that started it all... or at least, uh, lots.  `vint
pdp11-2bsd` will fire up the SIMH emulator of a PDP-11 running 2BSD
version 2.11.  Please note that this system doesn't automatically
boot, but needs a bit of help to get to a login prompt.  The
instructions for doing so are displayed on your screen as the
simulator starts.

Once in the simulator, hit Ctrl-E and then type `quit` to exit.

## PDP-11 with V5 Unix

A PDP-11 with [Version 5
Unix](https://en.wikipedia.org/wiki/Version_5_Unix) from 1974.  `vint
pdp11-unixv5` will fire it up for you and display instructions for
making it boot.

## PDP-11 with V6 Unix

A PDP-11 with [Version 6
Unix](https://en.wikipedia.org/wiki/Version_6_Unix) from 1975.  `vint
pdp11-unixv6` will fire it up for you and display instructions for
making it boot.

## PDP-11 with V7 Unix

A PDP-11 with [Version 7
Unix](https://en.wikipedia.org/wiki/Version_6_Unix) from 1979.  `vint
pdp11-unixv7` will fire it up for you and display instructions for
making it boot.  This version was the ancestor for many other Unixes
that have come since.

## Interdata 32b with V6 Unix

The [Interdata
32b](https://en.wikipedia.org/wiki/Interdata_7/32_and_8/32) running
the first non-DEC port of Unix.  This one is [Version 6
Unix](https://en.wikipedia.org/wiki/Version_6_Unix) from 1975.  `vint
interdata-unixv6` will fire it up for you and display instructions for
making it boot.

## Interdata 32b with V7 Unix

The [Interdata
32b](https://en.wikipedia.org/wiki/Interdata_7/32_and_8/32) running
the first non-DEC port of Unix.  This one is [Version 7
Unix](https://en.wikipedia.org/wiki/Version_7_Unix) from 1979.  `vint
interdata-unixv7` will fire it up for you and display instructions for
making it boot.

## PDP-10 with TOPS-20

The old TOPS-20 operating system on the PDP-10 - before Unix even!  I
know little about this system.  

Two systems are provided: a very basic one at `vint pdp10-tops20`, and
a more complete one at `vint pdp10-tops20-panda` running the [panda
dist](https://www.ldx.ca/notes/tops-20-notes.html).  The latter even
has EMACS and TECO installed; see the link for details.

The basic image uses SIMH; the panda one uses klt20.  Note: klt20 is
only provided in an ia32 executable, and will not run on Raspberry Pi.

You may find these links helpful:

- [TOPS-20 (TWENEX)
  notes](https://www.ldx.ca/notes/tops-20-notes.html)
- [Running TOPS-20 V4.1 under
  SIMH](http://gunkies.org/wiki/Running_TOPS-20_V4.1_under_SIMH)
- [TOPS-20 User's Guide](https://www.bourguet.org/v2/pdp10/users/)

## PDP-10 with TOPS-10

An even older operating system, running TOPS-10.  This is built with
the [TOPS-10 in a
box](https://www.filfre.net/2011/05/tops-10-in-a-box/) distribution.
The [README file](https://www.filfre.net/misc/TOPS-10.txt) is included
with the system, or may be accessed here, describes how to boot and
use this image.  Use `vint pdp10-tops10`.

## Data General NOVA with RDOS 7.5

This was a prime competitor to DEC.  It uses the RDOS [kit from
SIMH](http://simh.trailing-edge.com/software.html), which has been
installed for you using [wconrad's
instructions](https://wconrad.github.io/20151207/simh-nova-hello-world.html),
a copy of which is included in the generated image.  Those
instructions will be helpful to you.

`vint nova-rdos` will launch the simulator.  It requires keyboard
input to fully load; instructions are displayed before the simulator
starts.  The [RDOS
manual](bitsavers.trailing-edge.com/pdf/dg/software/rdos/093-000109-01_RDOS_Command_Line_Interpreter.pdf)
may be useful for you; it is also included in `/opt/vint/nova-rdos`
for your benefit.

To exit, type `RELEASE DP0` and then `quit` at the `sim>` prompt.
Ctrl-E will take you to the `sim>` prompt, which will let you perform
an unclean shutdown.

## SIMH in general

The [SIMH](http://simh.trailing-edge.com/) emulator is included in
full.  In fact, many of the other machines listed here are emulated
using SIMH.  It can emulate dozens of types of old big iron machines.

## 8086 with DOS

The operating system that took over the world (for a time): DOS on the
IBM PC.  This is the 8086tiny emulator running FreeDOS.  Check out its
documentation, because it can run everything from FreeDOS to even
Windows.  This version is compiled without graphics support, but it
can do graphics also if you compile it with SDL.

`vint dos-8086tiny` to start.

The system is fairly bare; much software can be downloaded and added
to this.

# Defining Additional `vint` Subcommands

You can extend the `vint` command on your own, either on a standalone
system or with a docker image based on this one.  To do so, create a
directory in `/opt/vint/systems`.  The directory name will be used as
the command name.  There must be at least one thing in the new
directory: an executable file named `run`.  This is what `vint` will
run.  Any other files you put in there are up to you.  See the
existing installed items for examples.  The name `list` is reserved
and not available for this purpose.

# Self-Installing OpenVMS on VAX with SIMH

[OpenVMS](https://en.wikipedia.org/wiki/OpenVMS) was a famous
operating system for DEC's VAX line.  OpenVMS is not included with
this image.  However, the SIMH simulator installed in it is capable of
running OpenVMS.

Various information is available online.  For instance:

- [VAX/VMS on Linux using
  SIMH](https://www.wherry.com/gadgets/retrocomputing/vax-simh.html)
  is a great overview.  This file is downloaded to
  `/opt/vint/downloads/vax-simh` for your reference as well.
- After that, [how to install
  DECwindows](http://mailman.trailing-edge.com/pipermail/simh/2006-November/000773.html)
  discusses installing the OpenVMS GUI.
- [Networking VAX OpenVMS on SIMH & the Raspberry
  Pi](https://mansfield-devine.com/speculatrix/2016/03/networking-vax-openvms-on-simh-the-raspberry-pi/) -
  despite its name, isn't specific to the Raspberry Pi
- [OpenVMS install
  log](https://raymii.org/s/blog/OpenVMS_7.3_install_log_with_simh_vax_on_Ubuntu_16.04.html)
- [How to build your own MicroVAX running VMS on
  SIMH](https://supratim-sanyal.blogspot.com/2016/10/how-to-build-your-own-digital-dec.html)
- [vaxhaven.com collection](https://vaxhaven.com/VaxHaven)
- There are also various videos on YouTube.

You will need to obtain a hobbyist OpenVMS license as well as the
software itself.  Here's how to do that:

- First, join DECUServe.  See the
  [instructions](https://eisner.decus.org/); as of 2019, you will need
  to `ssh REGISTRATION@eisner.decuserve.org` and log in with an empty
  password.  **Make note of your membership number and login details!**
- You may need to wait a week for the Hobbyist info to reach HPE; see
  [DECUServe hobbyist info](https://eisner.decus.org/)
- Get the registration link from DECUServe or [OpenVMS
  Hobbyist](http://www.openvmshobbyist.com/news.php); as of 2019, it
  is <https://www.hpe.com/h41268/live/index_e.aspx?qid=24548>.
- Fill out the registration form.  Your chapter is DECUServe, license
  type is VAX/Alpha, AllianceOne partner is No, emulator is SIMH.
- The form is processed by a human.  You'll get a reply with a license
  pak and download instructions - it seems to take about a business
  day, but may take longer.
- Now, you need media.  As of 2019, the email you'll get from HPE
  includes a sentence about replying back to ask for media downloads.
  Do that, specifying the VAX platform.  The will, after (it seems) a
  somewhat longer delay, reply back with time-limited credentials for
  obtaining the downloads.

# Updates (Raspberry Pi / Local Installations)

Note this will blow away any images you have, savegames, etc.

```
cd vintage-computing/setup
git pull
sudo mv /opt/vint/systems /opt/vin/systems.old
sudo ./setup.sh
sudo chown -R "`id -u`:`id -g`" /opt/vint
```

# Removal (Local Installations)

Be careful to type this in correctly!

```
rm -r /opt/vint
rm /usr/local/bin/vint
```

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

