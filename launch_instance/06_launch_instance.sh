#!/usr/bin/env bash

source keystonerc_user1
cat << EOF > userdata
#!/bin/bash
echo "Hello World!" >> /home/cloud-user/test
EOF

nova boot --flavor m1.small --image web --key-name key2 --security-groups sec2 --user-data userdata --poll testweb
nova floating-ip-create net2
nova add-floating-ip testweb 172.25.12.26
nova floating-ip-list
