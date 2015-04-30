#!/usr/bin/env bash

rm -rf key*.pem
source keystonerc_user1
nova keypair-add key2 > key2.pem
chmod 0600 key2.pem
nova secgroup-create sec2 "SSH and Web"
nova secgroup-add-rule sec2 tcp 22 22 0.0.0.0/0
nova secgroup-add-rule sec2 tcp 443 443 0.0.0.0/0
nova secgroup-add-rule sec2 icmp -1 -1 0.0.0.0/0
nova secgroup-add-group-rule sec2 sec2 tcp 80 80
nova secgroup-list-rules sec2
