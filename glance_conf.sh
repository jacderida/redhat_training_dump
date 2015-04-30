#!/usr/bin/env bash

crudini --set /etc/glance/glance-api.conf paste_deploy flavor keystone
crudini --set /etc/glance/glance-api.conf keystone_authtoken admin_tenant_name services
crudini --set /etc/glance/glance-api.conf keystone_authtoken admin_user glance
crudini --set /etc/glance/glance-api.conf keystone_authtoken admin_password redhat
crudini --set /etc/glance/glance-api.conf DEFAULT rabbit_userid rabbitmqauth
crudini --set /etc/glance/glance-api.conf DEFAULT rabbit_password redhat
crudini --set /etc/glance/glance-api.conf DEFAULT rabbit_host 172.25.12.10
crudini --set /etc/glance/glance-api.conf DEFAULT rabbit_use_ssl True
crudini --set /etc/glance/glance-api.conf DEFAULT rabbit_port 5671

crudini --set /etc/glance/glance-registry.conf paste_deploy flavor keystone
crudini --set /etc/glance/glance-registry.conf keystone_authtoken admin_tenant_name services
crudini --set /etc/glance/glance-registry.conf keystone_authtoken admin_user glance
crudini --set /etc/glance/glance-registry.conf keystone_authtoken admin_password redhat
