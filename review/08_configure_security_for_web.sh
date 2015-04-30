#!/usr/bin/env bash

rm -rf webkey.pem
source keystonerc_user1
nova keypair-add webkey > webkey.pem
chmod 0600 webkey.pem
nova secgroup-create web "SSH and Web"
nova secgroup-add-rule web tcp 22 22 0.0.0.0/0
nova secgroup-add-rule web tcp 443 443 0.0.0.0/0
nova secgroup-add-rule web icmp -1 -1 0.0.0.0/0
nova secgroup-add-group-rule web web tcp 80 80
nova secgroup-list-rules web
