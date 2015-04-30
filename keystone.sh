#!/usr/bin/env bash

function init_keystone() {
    yum install -y openstack-keystone
    yum install -y openstack-selinux
    yum install -y openstack-utils
}

function generate_token() {
    export SERVICE_TOKEN=$(openssl rand -hex 10)
    export SERVICE_ENDPOINT=http://server12-a.example.com:35357/v2.0
    echo $SERVICE_TOKEN > /root/ks_admin_token
}

init_keystone
openstack-db --init --service keystone -y -r redhat
keystone-manage pki_setup --keystone-user keystone --keystone-group keystone
generate_token
source keystonerc_token
crudini --set /etc/keystone/keystone.conf DEFAULT admin_token $SERVICE_TOKEN
systemctl start openstack-keystone
systemctl enable openstack-keystone
systemctl enable mariadb.service
firewall-cmd --add-port=35357/tcp --permanent
firewall-cmd --add-port=5000/tcp --permanent
firewall-cmd --reload
keystone service-create --name=keystone --type=identity --description="Keystone Identity Service"
# Note: The GUID used here needs to be parsed from the previous command.
keystone endpoint-create --service-id e9531ec0edfe462f81aa30d258b69069 --publicurl 'http://server12-a.example.com:5000/v2.0' --adminurl 'http://server12-a.example.com:35357/v2.0' --internalurl 'http://server12-a.example.com:5000/v2.0'


