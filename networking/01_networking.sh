#!/usr/bin/env bash

source ../keystonerc_admin
service_id=$(keystone service-create --name neutron --type network --description "OpenStack Networking Service" | grep "id" | cut -d '|' -f 3 | tr -d '[[:space:]]')
keystone endpoint-create --service-id $service_id --publicurl http://server12-a.example.com:9696 --adminurl http://server12-a.example.com:9696 --internalurl http://server12-a.example.com:9696
echo "Created service with ID $service_id"
