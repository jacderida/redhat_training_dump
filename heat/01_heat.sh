#!/usr/bin/env bash

yum install -y openstack-heat-*
yum install -y python-heatclient
yum install -y openstack-utils
yum install -y python-openstackclient
mysql_password=$(grep MYSQL_PW ../answers.txt | cut -d '=' -f 2)
export MYSQL_PW=$mysql_password
cat << EOF > mysql_batch
create database heat;
grant all privileges on heat.* to 'heat'@'localhost' identified by 'redhat';
grant all privileges on heat.* to 'heat'@'%' identified by 'redhat';
flush privileges;
quit;
EOF
mysql -u root -p$MYSQL_PW < mysql_batch
