#!/usr/bin/env bash

source ../keystonerc_admin
keystone user-create --name nova --pass redhat
keystone user-role-add --user nova --role admin --tenant services
