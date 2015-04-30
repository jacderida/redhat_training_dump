#!/usr/bin/env bash

source keystonerc_admin
glance image-create --name small --is-public True --disk-format qcow2 --container-format bare --copy-from http://classroom.example.com/pub/materials/small.img
