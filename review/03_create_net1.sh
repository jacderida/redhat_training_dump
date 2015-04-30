#!/usr/bin/env bash

source keystonerc_user1
neutron net-create net1
neutron subnet-create --name subnet1 net1 172.25.112.0/24
neutron router-create router1
neutron router-interface-add router1 subnet1
