#!/usr/bin/env bash

source keystonerc_admin
openstack-service restart cinder-scheduler
openstack-service restart cinder-volume
