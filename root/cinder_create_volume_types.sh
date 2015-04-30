#!/usr/bin/env bash

source keystonerc_admin
cinder type-create lvm
cinder type-key lvm set volume_backend_name=LVM
cinder type-create glusterfs
