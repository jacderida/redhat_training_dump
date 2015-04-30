#!/usr/bin/env bash

source ../keystonerc_admin
keystone user-create --name neutron --pass redhat
keystone user-role-add --user neutron --role admin --tenant services
