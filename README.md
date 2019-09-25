# weewx for Docker

This Docker image provides support for [WeeWX](http://www.weewx.com/).
Weewx is a simple, easy to use weather station.  It provides
a seamless upgrade from wview as well, so this is an easily-used
replacement for it.

WeeWX will require customization, so please consult the
instructions before beginning.

Some uses (such as with specialized hardware) may require
Docker to run in privileged mode; such cases are beyond the scope
of this manual.  However, serial devices can easily be used
on the host and presented to the Docker container via ser2net.
An increasing number of weather stations are network-enabled and
can communicate directly to this system.

You can view the [documentation for this image](https://github.com/jgoerzen/docker-weewx)
on its Github page.  This image is based on my [debian-base-security](https://github.com/jgoerzen/docker-debian-base)
image, which features automatic security updates to the operating system (though not WeeWX)
enabled by default.

WeeWX is most typically used with a local sqlite database.  If you intend to
use it with something else, you will probably need to install additional
software in the container.

I have provided rsync and ssh, however, since they are commonly used to push
pages to remote servers.

You can download with:

    docker pull jgoerzen/weewx

And run with something like this:

    docker run -td \
    --stop-signal=SIGRTMIN+3 \
    --tmpfs /run:size=100M --tmpfs /run/lock:size=100M \
    -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
    --hostname=weewx \
    -v /weatherdir:/var/lib/weewx:rw \
    --name=weewx jgoerzen/weewx

You almost certainly want to mount something over `/var/lib/weewx` so your
important data is preserved.  You will also want to have a way to preserve
the configuration in `/etc/weewx`.  By default, the `HTML_ROOT` value in
`/etc/weewx/weewx.conf` lists `/var/www/html/weewx`, so this would be an
excellent volume to export to a webserver container (such as my
[jgoerzen/debian-base-apache](https://github.com/jgoerzen/docker-debian-base)).

Consult the [WeeWX documentation](http://www.weewx.com/docs.html) for setup steps.

# Logging

Logging can be done either to Docker or in the container; see `DEBBASE_SYSLOG` as
documented in the [docker-debian-base docs](https://github.com/jgoerzen/docker-debian-base).

# Source

This is prepared by John Goerzen <jgoerzen@complete.org> and the source
can be found at https://github.com/jgoerzen/docker-weewx

# Security Status

The Debian operating system is configured to automatically apply security patches.
WeeWX, however, does not have such a feature.

# Copyright

Docker scripts, etc. are Copyright (c) 2017 John Goerzen.  
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

