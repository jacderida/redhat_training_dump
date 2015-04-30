#!/usr/bin/env bash

keystone user-create --name myuser --pass redhat
keystone role-create --name _member_
keystone tenant-create --name myopenstack
keystone user-role-add --user myuser --role _member_ --tenant myopenstack
