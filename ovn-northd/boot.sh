#!/bin/bash
ovs-appctl -t ovsdb-server ovsdb-server/add-remote ptcp:6640
/usr/local/share/openvswitch/scripts/ovn-ctl start_northd
tail -f /dev/null
