FROM ubuntu:14.04
RUN apt-get update
RUN apt-get install -y \
    gcc \
    make \
    build-essential \
    libssl-dev \
    autoconf \
    automake \
    libtool \
    python \
    python-pip \
    perl \
    git
RUN pip install Flask

WORKDIR /tmp
RUN git clone https://github.com/openvswitch/ovs

WORKDIR /tmp/ovs
RUN ./boot.sh
RUN ./configure
RUN make
RUN make install

RUN mkdir -p /usr/local/var/log/openvswitch \
    /usr/local/var/lib/openvswitch \
    /usr/local/var/lib/openvswitch/pki \
    /usr/local/var/run/openvswitch \
    /usr/local/etc/openvswitch

RUN rm -rf /tmp/ovs

ENTRYPOINT ["ovs-vswitchd", "--pidfile", "--log-file=/usr/local/var/log/openvswitch/ovs-vswitchd.log"]
