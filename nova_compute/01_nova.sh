#!/usr/bin/env bash

yum install -y openstack-nova
yum install -y openstack-nova-novncproxy
source ../keystonerc_admin
chown -R nova:nova /var/log/nova/
openstack-db --init --service nova --password redhat --rootpw redhat
