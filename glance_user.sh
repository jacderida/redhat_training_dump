#!/usr/bin/env bash

source keystonerc_admin
keystone user-create --name glance --pass redhat
keystone user-role-add --user glance --role admin --tenant services
keystone service-create --name glance --type image --description "OpenStack Image Service"
# Note: The GUID used here needs to be parsed from the output of the previous command.
keystone endpoint-create --service-id 5551bc9b319b4106a17297c5c8d13d1e --publicurl http://server12-a.example.com:9292 --adminurl http://server12-a.example.com:9292 --internalurl http://server12-a.example.com:9292
firewall-cmd --add-port=9292/tcp --permanent
firewall-cmd --reload
