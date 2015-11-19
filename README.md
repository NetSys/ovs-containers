# Open vSwitch Containers
Containerized versions of Open vSwitch

## Building
To install just run `make`. This will build new images with the tags
`ovs-vswitchd`, `ovsdb`, `ovn-northd`, and `ovn-controller`.

## Using
These containers need to share `/usr/local/var/run/openvswitch`, so they can
communicate, and privileged access to the host and its network interfaces.
This is primarily so ovs-vswitchd can load the ovs kernel module.

### Typical deployment
The following script will boot ovsdb and ovs-vswitchd  per [INSTALL.md]

    mkdir -p /var/run/ovs

    docker run -d --privileged --net=host --name=ovsdb \
        -v /var/run/ovs:/usr/local/var/run/openvswitch:rw \
        ovsdb

    docker run -d --privileged --net=host --name=ovs-vswitchd \
        -v /var/run/ovs:/usr/local/var/run/openvswitch:rw \
        ovs-vswitchd

Then the usual ovs utitlies like `ovs-vsctl`, `ovs-ofctl`, etc... can be run
by simply prepending `docker exec ovs-vswitchd`, or `docker exec ovsdb` depending
on which utility you are running, to the command line.

### OVN Overlay Network with Docker
If you wanted to use OVN to create an overlay network between docker containers
using geneve tunneling between hosts, the following scripts would do the job
(See [INSTALL.Docker.md] for more details about using OVN with docker).

On the northd host:

    mkdir -p /var/run/ovs

    docker run -d --privileged --net=host --name=ovsdb \
        -v /var/run/ovs:/usr/local/var/run/openvswitch:rw \
        ovsdb

    docker run -d --privileged --net=host --name=ovs-northd \
        -v /var/run/ovs:/usr/local/var/run/openvswitch:rw \
        ovn-northd

On each host running containers:

    mkdir -p /var/run/ovs

    docker run -d --privileged --net=host --name=ovsdb \
        -v /var/run/ovs:/usr/local/var/run/openvswitch:rw \
        ovsdb

    docker run -d --privileged --net=host --name=ovs-vswitchd \
        -v /var/run/ovs:/usr/local/var/run/openvswitch:rw \
        -v /var/run/docker.sock:/var/run/docker.sock:rw \
        -v /etc/docker:/etc/docker:rw \
        ovs-vswitchd

    docker exec ovs-vswitchd ovs-vsctl set Open_vSwitch . \
        external_ids:ovn-remote="tcp:<NORTHD_HOST_IP>:6640" \
        external_ids:ovn-encap-ip=<LOCAL_IP> \
        external_ids:ovn-encap-type="geneve"

    docker run -d --privileged --net=host --name=ovn-controller \
        -v /var/run/ovs:/usr/local/var/run/openvswitch:rw \
        -v /var/run/docker.sock:/var/run/docker.sock:rw \
        -v /etc/docker:/etc/docker:rw \
        ovn-controller

    docker exec ovn-controller ovn-docker-overlay-driver --detach

Then, to create a logical switch, run:

    docker network create -d openvswitch --subnet=192.168.1.0/24 foo

and connect containers by passing `--net=foo` to docker when running new
containers.
