#!/usr/bin/env bash

source keystonerc_user1
glance image-create --name web --is-public True --disk-format qcow2 --container-format bare --copy-from http://classroom.example.com/materials/web.img
