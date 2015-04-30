#!/usr/bin/env bash

yum install -y openstack-swift-proxy
yum install -y openstack-swift-object
yum install -y openstack-swift-container
yum install -y openstack-swift-account
yum install -y python-swiftclient
yum install -y memcached
source /root/keystonerc_admin
keystone user-create --name swift --pass redhat
keystone tenant-create --name services
keystone user-role-add --role admin --tenant services --user swift
keystone service-create --name swift --type object-store --description "Swift Storage Service"
# Note: The GUID used here needs to be parsed from the previous command.
 keystone endpoint-create --service-id 04291b9ac0c64036a79e7b677685e93d --publicurl "http://server12-a.example.com:8080/v1/AUTH_%(tenant_id)s" --adminurl "http://server12-a.example.com:8080/v1/AUTH_%(tenant_id)s" --internalurl "http://server12-a.example.com:8080/v1/AUTH_%(tenant_id)s"
