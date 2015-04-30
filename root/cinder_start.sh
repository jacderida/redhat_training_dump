#!/usr/bin/env bash

systemctl enable openstack-cinder-api
systemctl enable openstack-cinder-scheduler
systemctl enable openstack-cinder-volume
openstack-service start cinder
