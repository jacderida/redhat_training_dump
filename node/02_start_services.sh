#!/usr/bin/env bash

systemctl start libvirtd
systemctl start openstack-nova-compute
systemctl enable libvirtd
systemctl enable openstack-nova-compute
