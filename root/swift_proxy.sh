#!/usr/bin/env bash

source keystonerc_admin
cp /etc/swift/proxy-server.conf /etc/swift/proxy-server.conf.orig
crudini --set /etc/swift/proxy-server.conf filter:authtoken admin_tenant_name services
crudini --set /etc/swift/proxy-server.conf filter:authtoken identity_uri http://172.25.12.10:35357
crudini --set /etc/swift/proxy-server.conf filter:authtoken admin_user swift
crudini --set /etc/swift/proxy-server.conf filter:authtoken admin_password redhat

systemctl start memcached
systemctl start openstack-swift-proxy
systemctl enable memcached
systemctl enable openstack-swift-proxy
