all:
	docker build -t quilt/ovs:vswitchd ./ovs-vswitchd
	docker build -t quilt/ovs:ovsdb ./ovsdb-server
	docker build -t quilt/ovs:ovn-northd ./ovn-northd
	docker build -t quilt/ovs:ovn-controller ./ovn-controller
	docker build -t quilt/ovs:latest .

push:
	docker push quilt/ovs:latest
	docker push quilt/ovs:vswitchd
	docker push quilt/ovs:ovsdb
	docker push quilt/ovs:ovn-northd
	docker push quilt/ovs:ovn-controller
