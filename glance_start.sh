#!/usr/bin/env bash

systemctl start openstack-glance-registry
systemctl enable openstack-glance-registry
systemctl start openstack-glance-api
systemctl enable openstack-glance-api
