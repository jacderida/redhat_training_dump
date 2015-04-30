#!/usr/bin/env bash

source ../keystonerc_admin
service_id=$(keystone service-create --name nova --type compute --description "OpenStack Compute Service" | grep "id" | cut -d '|' -f 3 | tr -d '[[:space:]]')
keystone endpoint-create --service-id $service_id --publicurl 'http://server12-a.example.com:8774/v2/%(tenant_id)s' --adminurl 'http://server12-a.example.com:8774/v2/%(tenant_id)s' --internalurl 'http://server12-a.example.com:8774/v2/%(tenant_id)s' 
echo "Created service with ID $service_id"
