all:
	docker build -t quay.io/netsys/ovs-base .
	docker build -t quay.io/netsys/ovs-vswitchd ./ovs-vswitchd
	docker build -t quay.io/netsys/ovsdb ./ovsdb
	docker build -t quay.io/netsys/ovn-northd ./ovn-northd
	docker build -t quay.io/netsys/ovn-controller ./ovn-controller

push:
	docker push quay.io/netsys/ovs-base
	docker push quay.io/netsys/ovs-vswitchd
	docker push quay.io/netsys/ovn-northd
	docker push quay.io/netsys/ovn-controller
	docker push quay.io/netsys/ovsdb
