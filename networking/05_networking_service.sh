#!/usr/bin/env bash

source ../keystonerc_admin
openstack-db --init --service neutron --password redhat --rootpw redhat
neutron-db-manage --config-file /etc/neutron/neutron.conf --config-file /etc/neutron/plugin.ini upgrade head
systemctl start neutron-server.service
systemctl enable neutron-server.service
systemctl start openvswitch.service
systemctl enable openvswitch.service
