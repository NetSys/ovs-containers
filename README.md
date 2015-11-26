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

    docker run -d --net=host --name=ovsdb-server quay.io/netsys/ovsdb-server

    docker run -d --volumes-from ovsdb-server --privileged --net=host \
    --name=ovs-vswitchd quay.io/netsys/ovs-vswitchd

Then the usual ovs utitlies like `ovs-vsctl`, `ovs-ofctl`, etc... can be run
by simply prepending `docker exec ovs-vswitchd`, or `docker exec ovsdb` depending
on which utility you are running, to the command line.

### OVN Overlay Network with Docker
If you wanted to use OVN to create an overlay network between docker containers
using geneve tunneling between hosts, the following scripts would do the job
(See [INSTALL.Docker.md] for more details about using OVN with docker).

On the northd host:

    docker run -d --net=host --name=ovsdb-server quay.io/netsys/ovsdb-server

    docker run -d --net=host --volumes-from ovsdb-server --name=ovn-northd \
    quay.io/netsys/ovn-northd -v /var/run/docker.sock

On each host running containers:

    docker run -d --net=host --name=ovsdb-server quay.io/netsys/ovsdb-server

    docker run -d --volumes-from ovsdb-server --privileged --net=host \
    --name=ovs-vswitchd quay.io/netsys/ovs-vswitchd

    docker run -d --net=host --volumes-from ovsdb-server --name=ovs-northd \
    quay.io/netsys/ovn-northd

    docker exec ovn-controller ovn-docker-overlay-driver --detach

Then, to create a logical switch, run:

    docker network create -d openvswitch --subnet=192.168.1.0/24 foo

and connect containers by passing `--net=foo` to docker when running new
containers.
