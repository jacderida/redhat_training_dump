#!/usr/bin/env bash

source keystonerc_admin
keystone user-create --name cinder --pass redhat
keystone user-role-add --user cinder --role admin --tenant services
