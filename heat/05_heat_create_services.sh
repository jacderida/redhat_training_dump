#!/usr/bin/env bash

source ../keystonerc_admin
echo "Creating heat user"
keystone user-create --name heat
echo "Adding heat user to admin role"
keystone user-role-add --user heat --role admin --tenant services
heat_service_id=$(keystone service-create --name heat --type orchestration --description "Heat Orchestration Service" | grep "id" | cut -d '|' -f 3 | tr -d '[[:space:]]')
keystone endpoint-create --region RegionOne --service-id $heat_service_id --publicurl 'http://server12-a.example.com:8004/v1/%(tenant_id)s' --adminurl 'http://server12-a.example.com:8004/v1/%(tenant_id)s' --internalurl 'http://server12-a.example.com:8004/v1/%(tenant_id)s' 
echo "Created heat service with ID $heat_service_id"

heat_cfn_service_id=$(keystone service-create --name heat-cfn --type cloudformation --description "Heat CloudFormation Service" | grep "id" | cut -d '|' -f 3 | tr -d '[[:space:]]')
keystone endpoint-create --region RegionOne --service-id $heat_cfn_service_id --publicurl 'http://server12-a.example.com:8000/v1' --adminurl 'http://server12-a.example.com:8000/v1' --internalurl 'http://server12-a.example.com:8000/v1' 
echo "Created heat cfn service with ID $heat_cfn_service_id"

keystone role-create --name heat_stack_user
echo "Created heat_stack_user_role"

admin_token=$(grep admin_token /etc/keystone/keystone.conf | cut -d '=' -f 2 | tail -1)
domain_id=$(openstack --os-token=$admin_token --os-url=http://172.25.12.10:5000/v3 --os-identity-api-version=3 domain create heat --description "Owns users and tenants created by Heat" | grep "id" | cut -d '|' -f 3 | tr -d '[[:space:]]')
echo "Created domain with ID $domain_id"

domain_user_id=$(openstack --os-token=$admin_token --os-url=http://172.25.12.10:5000/v3 --os-identity-api-version=3 user create --password redhat --domain $domain_id --description "Manages users and projects created by heat" heatmanager | grep "id" | tail -1 | cut -d '|' -f 3 | tr -d '[[:space:]]')
echo "Created domain user with ID $domain_user_id"

openstack --os-token=$admin_token --os-url=http://172.25.12.10:5000/v3 --os-identity-api-version=3 role add --user $domain_user_id --domain $domain_id admin

crudini --set /etc/heat/heat.conf DEFAULT stack_user_domain $domain_id
crudini --set /etc/heat/heat.conf DEFAULT stack_domain_admin $domain_user_id
crudini --set /etc/heat/heat.conf DEFAULT stack_domain_admin_password redhat
