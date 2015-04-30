#!/usr/bin/env bash

source keystonerc_admin
cinder create --volume-type lvm --display-name vol2 1
cinder create --volume-type glusterfs --display-name vol3 1
