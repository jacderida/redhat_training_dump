#!/usr/bin/env bash

source ../keystonerc_admin
neutron net-create --tenant-id services net2 --router:external=True
neutron subnet-create --tenant-id services --allocation-pool start=172.25.12.25,end=172.25.12.99 --gateway 172.25.12.254 --disable-dhcp --name subnet2 net2 172.25.12.0/24
neutron router-gateway-set router1 net2
