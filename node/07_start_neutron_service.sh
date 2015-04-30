#!/usr/bin/env bash

systemctl start neutron-openvswitch-agent
systemctl enable neutron-openvswitch-agent
systemctl start neutron-ovs-cleanup
systemctl enable neutron-ovs-cleanup
