#!/usr/bin/env bash

keystone user-create --name admin --pass redhat
keystone role-create --name admin
keystone tenant-create --name admin
keystone user-role-add --user admin --role admin --tenant admin
