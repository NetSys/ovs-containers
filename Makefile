all:
	docker build -t ovs-vswitchd ./ovs-vswitchd
	docker build -t ovsdb ./ovsdb
	docker build -t ovn-northd ./ovn-northd
	docker build -t ovn-controller ./ovn-controller
