FROM jgoerzen/debian-base-standard:bookworm
MAINTAINER John Goerzen <jgoerzen@complete.org>
RUN mv /usr/sbin/policy-rc.d.disabled /usr/sbin/policy-rc.d && \
    apt-get update && \
    apt-get -y -u dist-upgrade && \
    apt-get -y install wget git make

# pre-seed the cache a bit
COPY setup/download.sh /tmp/download.sh
RUN mkdir -p /opt/vint/downloads && \
    cd /opt/vint/downloads && \
    /tmp/download.sh && \
    rm /tmp/download.sh
COPY setup/instpkgs.sh /tmp/instpkgs.sh
RUN /tmp/instpkgs.sh && rm /tmp/instpkgs.sh

# Now do the setup
COPY setup/ /opt/vint/setup
RUN adduser --uid 2000 --disabled-password --gecos 'Runner' pi
RUN /opt/vint/setup/setup.sh && chown -R pi:pi /opt/vint
RUN apt-get clean && rm -rf /tmp/setup /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    /usr/local/bin/docker-wipelogs && \
    mv /usr/sbin/policy-rc.d /usr/sbin/policy-rc.d.disabled

CMD ["/usr/local/bin/boot-debian-base"]
