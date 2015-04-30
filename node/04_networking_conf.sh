#!/usr/bin/env bash
cd /etc/neutron/plugins
cp openvswitch/ovs_neutron_plugin.ini openvswitch/ovs_neutron_plugin.ini.orig
cp ml2/ml2_conf.ini ml2/ml2_conf.ini.orig
cp /etc/neutron/neutron.conf /etc/neutron/neutron.conf.orig

scp server12-a:/etc/neutron/plugins/openvswitch/ovs_neutron_plugin.ini openvswitch/
scp server12-a:/etc/neutron/plugins/ml2/ml2_conf.ini ml2/
scp server12-a:/etc/neutron/neutron.conf /etc/neutron
ln -s /etc/neutron/plugins/ml2/ml2_conf.ini /etc/neutron/plugin.ini
