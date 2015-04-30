#!/usr/bin/env bash

source ../keystonerc_admin
nova flavor-create m2.tiny m2.tiny 1024 20 1 --ephemeral 2 --swap 512
source keystonerc_user1
glance image-create --name small --is-public True --disk-format qcow2 --container-format bare --copy-from http://classroom.example.com/materials/small.img
