#!/usr/bin/env 

yum install -y openstack-glance
cp /etc/glance/glance-registry.conf /etc/glance/glance-registry.conf.orig
cp /etc/glance/glance-api.conf /etc/glance/glance-api.conf.orig
cp -f /usr/share/glance/glance-registry-dist.conf /etc/glance/glance-registry.conf
cp -f /usr/share/glance/glance-api-dist.conf /etc/glance/glance-api.conf
openstack-db --init --service glance --password redhat --rootpw redhat
