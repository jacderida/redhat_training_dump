#!/usr/bin/env bash

setsebool -P httpd_can_network_connect on
systemctl start httpd
systemctl enable httpd
firewall-cmd --add-service=http --permanent
firewall-cmd --add-service=https --permanent
firewall-cmd --add-port=6080/tcp --permanent
firewall-cmd --reload
