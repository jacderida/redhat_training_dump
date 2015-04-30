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

#init_keystone
#openstack-db --init --service keystone -y -r redhat
#keystone-manage pki_setup --keystone-user keystone --keystone-group keystone
generate_token
