#!/bin/bash
/usr/local/share/openvswitch/scripts/ovn-ctl start_controller
tail -f /usr/local/var/log/openvswitch/ovsdb-server.log
