#!/usr/bin/env bash

export ENCKEY=$(openssl rand -hex 16)
crudini --set /etc/heat/heat.conf DEFAULT auth_encryption_key ${ENCKEY}
crudini --set /etc/heat/heat.conf database connection mysql://heat:redhat@172.25.12.10/heat
crudini --set /etc/heat/heat.conf DEFAULT sql_connection mysql://heat:redhat@172.25.12.10/heat
crudini --set /etc/heat/heat.conf DEFAULT rpc_backend heat.openstack.common.rpc.impl_kombu
crudini --set /etc/heat/heat.conf keystone_authtoken admin_tenant_name services
crudini --set /etc/heat/heat.conf keystone_authtoken admin_user heat
crudini --set /etc/heat/heat.conf keystone_authtoken admin_password redhat
crudini --set /etc/heat/heat.conf keystone_authtoken auth_port 35357
crudini --set /etc/heat/heat.conf keystone_authtoken auth_host 172.25.12.10
crudini --set /etc/heat/heat.conf keystone_authtoken auth_protocol http
crudini --set /etc/heat/heat.conf keystone_authtoken auth_uri http://172.25.12.10:5000/v2.0
crudini --set /etc/heat/heat.conf ec2authtoken auth_uri http://172.25.12.10:35357/v2.0
