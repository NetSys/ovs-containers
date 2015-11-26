FROM ubuntu:14.04

ENV deps \
    build-essential \
    libtool \
    autoconf \
    pkg-config \
    libssl-dev \
    git \
    python \
    perl

WORKDIR /tmp/ovs
RUN \
apt-get update \
&& apt-get install -y ${deps} \
&& git clone https://github.com/openvswitch/ovs /tmp/ovs \
&& ./boot.sh \
&& ./configure --prefix="/" \
&& make install \
&& mkdir -p /var/log/openvswitch \
            /var/lib/openvswitch/pki \
            /var/run/openvswitch \
            /etc/openvswitch \
&& apt-get purge -y ${deps} \
&& apt-get autoremove -y --purge \
&& rm -rf /tmp/ovs
