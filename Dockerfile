FROM jgoerzen/debian-base-standard:buster
MAINTAINER John Goerzen <jgoerzen@complete.org>
RUN mv /usr/sbin/policy-rc.d.disabled /usr/sbin/policy-rc.d && \
    apt-get update && \
    apt-get -y -u dist-upgrade && \
    apt-get -y install wget git

# pre-seed the cache a bit
COPY setup/download.sh /tmp/download.sh
RUN mkdir -p /opt/vint/download && \
    cd /opt/vint/download && \
    /tmp/download.sh && \
    rm /tmp/download.sh

# Now do the setup
COPY setup/ /opt/vint/setup
RUN adduser --uid 2000 --disabled-password --gecos 'Runner' runner
RUN /opt/vint/setup/setup.sh
RUN apt-get clean && rm -rf /tmp/setup /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    /usr/local/bin/docker-wipelogs && \
    mv /usr/sbin/policy-rc.d /usr/sbin/policy-rc.d.disabled && \
    rm -r /tmp/setup

CMD ["/usr/local/bin/boot-debian-base"]
