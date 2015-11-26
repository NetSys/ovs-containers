FROM quay.io/netsys/ovs-base

RUN ovsdb-tool create /etc/openvswitch/conf.db \
    /share/openvswitch/vswitch.ovsschema

ENTRYPOINT ["ovsdb-server", \
    "--remote=punix:/usr/local/var/run/openvswitch/db.sock", \
    "--remote=db:Open_vSwitch,Open_vSwitch,manager_options", \
    "--log-file=/usr/local/var/log/openvswitch/ovsdb-server.log", \
    "--pidfile"]
