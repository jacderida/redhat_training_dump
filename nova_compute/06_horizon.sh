#!/usr/bin/env bash

yum install -y mod_wsgi
yum install -y httpd
yum install -y mod_ssl
yum install -y openstack-dashboard
yum install -y memcached
yum install -y python-memcached
sed "s/ALLOWED_HOSTS = \['.*'\]/ALLOWED_HOSTS = \['\*'\]/" -i /etc/openstack-dashboard/local_settings
sed 's/OPENSTACK_HOST = ".*"/OPENSTACK_HOST = "172\.25\.12\.10"/' -i /etc/openstack-dashboard/local_settings
