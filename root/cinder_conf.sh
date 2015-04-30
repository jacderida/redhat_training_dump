#!/usr/bin/env bash

crudini --set /etc/cinder/cinder.conf keystone_authtoken admin_tenant_name services
crudini --set /etc/cinder/cinder.conf keystone_authtoken admin_user cinder
crudini --set /etc/cinder/cinder.conf keystone_authtoken admin_password redhat
crudini --set /etc/cinder/cinder.conf DEFAULT rabbit_userid rabbitmqauth
crudini --set /etc/cinder/cinder.conf DEFAULT rabbit_password redhat
crudini --set /etc/cinder/cinder.conf DEFAULT rabbit_host server12-a.example.com
crudini --set /etc/cinder/cinder.conf DEFAULT rabbit_use_ssl True
crudini --set /etc/cinder/cinder.conf DEFAULT rabbit_port 5671
