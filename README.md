# Open vSwitch Containers
Containerized versions of Open vSwitch

To install just run `make`. This will build new images with the tags `ovs`,
`ovsdb`, `ovn-northd`, and `ovn-controller`.

These containers need to share `/usr/local/var/run/openvswitch`, to communicate
with eachother, and privileged access to the host and its network interfaces.
This is primarily so ovs-vswitchd can load the ovs kernel module.
So, to run them create a directory on the host 

    mkdir -p /var/run/ovs

and mount it on each container while booting it with the following command

    docker run -d --privileged --net=host \
        -v /var/run/ovs:/usr/local/var/run/openvswitch:rw
        <image-name>
