#!/usr/bin/env bash

source ../keystonerc_admin
keystone user-create --name user1 --pass redhat
keystone tenant-create --name myproject
keystone role-create --name _member_
keystone user-role-add --user user1 --role _member_ --tenant myproject

cat << EOF > keystonerc_user1
unset SERVICE_TOKEN SERVICE_ENDPOINT
export OS_USERNAME=user1
export OS_TENANT_NAME=myproject
export OS_PASSWORD=redhat
export OS_AUTH_URL=http://server12-a.example.com:5000/v2.0/
export PS1='[\u@\h \W(keystone_user1)]\$ '
EOF
