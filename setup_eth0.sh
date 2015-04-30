#!/usr/bin/env bash

cat << EOF > /etc/sysconfig/network-scripts/ifcfg-eth0
DEVICE=eth0
ONBOOT=yes
TYPE=OVSPort
DEVICETYPE=ovs
OVS_BRIDGE=br-ex
EOF
cat << EOF > /etc/sysconfig/network-scripts/ifcfg-br-ex
DEVICE=br-ex
BOOTPROTO=static
ONBOOT=yes
TYPE=OVSBridge
DEVICETYPE=ovs
USERCTL=yes
PEERDNS=yes
IPV6INIT=no
IPADDR=172.25.12.10
NETMASK=255.255.255.0
GATEWAY=172.25.12.254
DNS1=172.25.254.254
EOF
ovs-vsctl add-port br-ex eth0
systemctl restart network.service
hostnamectl set-hostname server12-a.example.com
sed -i "/:nova-api-INPUT - \[0:0\]/a -A INPUT -s 172\.25\.12\.11 -j ACCEPT" /etc/sysconfig/iptables
systemctl restart iptables
