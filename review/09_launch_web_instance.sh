#!/usr/bin/env bash

source keystonerc_user1
cat << EOF > userdata
#!/bin/bash
echo "Hello World!" >> /home/cloud-user/test
EOF

nova boot --flavor m1.small --image web --key-name webkey --security-groups web --user-data userdata --poll web
nova floating-ip-create net2
nova add-floating-ip web 172.25.12.27
nova floating-ip-list
