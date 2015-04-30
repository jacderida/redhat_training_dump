#!/usr/bin/env bash

yum install -y glusterfs-fuse
cp /etc/cinder/cinder.conf /etc/cinder/cinder.conf.orig
glusterfs -s rhs.example.com --volfile-id=/volume12 /mnt/
df
umount /mnt/
