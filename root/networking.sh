#!/usr/bin/env bash

source keystonerc_admin
keystone service-create --name neutron --type network --description "OpenStack Networking Service"
keystone endpoint-create --service-id 46b5b28e2f974fdcbd29155478e07d06 --publicurl http://server12-a.example.com:9696 --adminurl http://server12-a.example.com:9696 --internalurl http://server12-a.example.com:9696
