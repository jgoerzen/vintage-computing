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

The directory `/vint/systems` will contain information for most
systems included here, particularly inside the `files` directory.

You may see files ending with a number; for instance, `foo.1`.  In
those cases, you can display the documentation with a command like
`man -l foo.1`.

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

