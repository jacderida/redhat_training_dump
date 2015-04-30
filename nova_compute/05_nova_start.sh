#!/usr/bin/env bash

systemctl start libvirtd
systemctl start openstack-nova-scheduler
systemctl start openstack-nova-conductor
systemctl start openstack-nova-api
systemctl start openstack-nova-compute
systemctl start openstack-nova-consoleauth
systemctl start openstack-nova-novncproxy
systemctl enable openstack-nova-scheduler
systemctl enable openstack-nova-conductor
systemctl enable openstack-nova-api
systemctl enable openstack-nova-compute
systemctl enable openstack-nova-consoleauth
systemctl enable openstack-nova-novncproxy
