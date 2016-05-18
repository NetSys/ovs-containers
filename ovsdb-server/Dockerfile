FROM quilt/ovs:latest

ENTRYPOINT ["ovsdb-server", \
    "--remote=punix:/var/run/openvswitch/db.sock", \
    "--remote=ptcp:6640", \
    "--remote=db:Open_vSwitch,Open_vSwitch,manager_options", \
    "--log-file=/var/log/openvswitch/ovsdb-server.log", \
    "--pidfile", "/etc/openvswitch/conf.db", "/etc/openvswitch/ovnnb.db", \
    "/etc/openvswitch/ovnsb.db"]
