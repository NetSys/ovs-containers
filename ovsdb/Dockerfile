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
    perl \
    git

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
RUN ovsdb-tool create /usr/local/etc/openvswitch/conf.db \
    /usr/local/share/openvswitch/vswitch.ovsschema

RUN rm -rf /tmp/ovs

ENTRYPOINT ["ovsdb-server", \
    "--remote=punix:/usr/local/var/run/openvswitch/db.sock", \
    "--remote=db:Open_vSwitch,Open_vSwitch,manager_options", \
    "--log-file=/usr/local/var/log/openvswitch/ovsdb-server.log", \
    "--pidfile"]
