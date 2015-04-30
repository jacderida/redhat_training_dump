#!/usr/bin/env bash

source keystonerc_admin
keystone service-create --name=cinder --type=volume --description="OpenStack Block Storage Service"
# Note: The GUID needs to be parsed from the output of the previous command.
keystone endpoint-create --service-id a10eb894a291440291547d6d90ccd31b --publicurl 'http://server12-a.example.com:8776/v1/%(tenant_id)s' --adminurl 'http://server12-a.example.com:8776/v1/%(tenant_id)s' --internalurl 'http://server12-a.example.com:8776/v1/%(tenant_id)s'
keystone service-create --name=cinderv2 --type=volume2 --description="OpenStack Block Storage Service v2"
# Note: The GUID needs to be parsed from the output of the previous command.
keystone endpoint-create --service-id 125a4a7e1667421b9c9b0fb14af6ac0e --publicurl 'http://server12-a.example.com:8776/v2/%(tenant_id)s' --adminurl 'http://server12-a.example.com:8776/v2/%(tenant_id)s' --internalurl 'http://server12-a.example.com:8776/v2/%(tenant_id)s'
