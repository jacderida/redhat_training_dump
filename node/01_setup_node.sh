#!/usr/bin/env bash

yum install -y openstack-nova-compute
yum install -y openstack-utils
cp /etc/nova/nova.conf /etc/nova/nova.conf.orig
scp root@server12-a:/etc/nova/nova.conf /etc/nova/nova.conf
scp root@server12-a:/etc/nova/api-paste.ini /etc/nova/api-paste.ini
chown root:nova /etc/nova/nova.conf
chown -R nova:nova /var/log/nova

crudini --set /etc/nova/nova.conf DEFAULT my_ip 172.25.12.11
crudini --set /etc/nova/nova.conf DEFAULT vncserver_proxyclient_address \$my_ip
crudini --set /etc/nova/nova.conf DEFAULT vncserver_listen 0.0.0.0 
crudini --set /etc/nova/nova.conf DEFAULT glance_host 172.25.12.10
crudini --set /etc/nova/nova.conf libvirt virt_type qemu
