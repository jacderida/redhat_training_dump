#!/usr/bin/env bash

yum install -y openstack-cinder
cp /etc/cinder/cinder.conf /etc/cinder/cinder.conf.orig
cp -f /usr/share/cinder/cinder-dist.conf /etc/cinder/cinder.conf
source keystonerc_admin
openstack-db --init --service cinder --password redhat --rootpw redhat
