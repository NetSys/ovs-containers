#!/bin/bash
/usr/share/openvswitch/scripts/ovn-ctl start_northd
tail -f /dev/null
