#!/usr/bin/env bash

crudini --set /etc/cinder/cinder.conf DEFAULT enabled_backends glusterfs,lvm
crudini --set /etc/cinder/cinder.conf lvm volume_group cinder-volumes
crudini --set /etc/cinder/cinder.conf lvm volume_driver cinder.volume.drivers.lvm.LVMISCSIDriver
crudini --set /etc/cinder/cinder.conf lvm volume_backend_name LVM
crudini --set /etc/cinder/cinder.conf glusterfs volume_driver cinder.volume.drivers.glusterfs.GlusterfsDriver
crudini --set /etc/cinder/cinder.conf glusterfs glusterfs_shares_config /etc/cinder/shares.conf
crudini --set /etc/cinder/cinder.conf glusterfs glusterfs_sparsed_volumes false
crudini --set /etc/cinder/cinder.conf glusterfs volume_backend_name RHS

echo "rhs.example.com:/volume12" > /etc/cinder/shares.conf
