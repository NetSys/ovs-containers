all:
	docker build -t ovs ./ovs
	docker build -t ovsdb ./ovsdb
	docker build -t ovn-northd ./ovn-northd
	docker build -t ovn-controller ./ovn-controller
