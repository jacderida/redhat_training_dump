#!/usr/bin/env bash

crudini --set /etc/neutron/neutron.conf DEFAULT auth_strategy keystone
crudini --set /etc/neutron/neutron.conf keystone_authtoken admin_tenant_name services
crudini --set /etc/neutron/neutron.conf keystone_authtoken admin_user neutron
crudini --set /etc/neutron/neutron.conf keystone_authtoken admin_password redhat
crudini --set /etc/neutron/neutron.conf database connection mysql://neutron:redhat@172.25.12.10/neutron
crudini --set /etc/neutron/neutron.conf DEFAULT rabbit_userid rabbitmqauth
crudini --set /etc/neutron/neutron.conf DEFAULT rabbit_password redhat
crudini --set /etc/neutron/neutron.conf DEFAULT rabbit_host server12-a.example.com
crudini --set /etc/neutron/neutron.conf DEFAULT rabbit_use_ssl True
crudini --set /etc/neutron/neutron.conf DEFAULT rabbit_port 5671
crudini --set /etc/neutron/neutron.conf DEFAULT notify_nova_on_port_status_changes True
crudini --set /etc/neutron/neutron.conf DEFAULT notify_nova_on_port_data_changes True
crudini --set /etc/neutron/neutron.conf DEFAULT nova_url http://172.25.12.10:8774/v2
crudini --set /etc/neutron/neutron.conf DEFAULT nova_admin_username nova
crudini --set /etc/neutron/neutron.conf DEFAULT nova_admin_tenant_id $(keystone tenant-list | awk '/ services / { print $2 }')
crudini --set /etc/neutron/neutron.conf DEFAULT nova_admin_password redhat
crudini --set /etc/neutron/neutron.conf DEFAULT nova_admin_auth_url http://172.25.12.10:35357/v2.0

cp /etc/neutron/metadata_agent.ini /etc/neutron/metadata_agent.ini.orig
crudini --set /etc/neutron/metadata_agent.ini DEFAULT admin_tenant_name services
crudini --set /etc/neutron/metadata_agent.ini DEFAULT admin_user neutron
crudini --set /etc/neutron/metadata_agent.ini DEFAULT admin_password redhat
crudini --set /etc/neutron/metadata_agent.ini DEFAULT auth_url http://172.25.12.10:35357/v2.0
crudini --set /etc/neutron/metadata_agent.ini DEFAULT nova_metadata_ip 172.25.12.10
crudini --set /etc/neutron/metadata_agent.ini DEFAULT metadata_proxy_shared_secret redhat
crudini --set /etc/neutron/metadata_agent.ini DEFAULT auth_region regionOne

cp /etc/neutron/plugins/ml2/ml2_conf.ini /etc/neutron/plugins/ml2/ml2_conf.ini.orig
ln -s /etc/neutron/plugins/ml2/ml2_conf.ini /etc/neutron/plugin.ini
crudini --set /etc/neutron/neutron.conf DEFAULT core_plugin neutron.plugins.ml2.plugin.Ml2Plugin
crudini --set /etc/neutron/neutron.conf DEFAULT service_plugins neutron.services.l3_router.l3_router_plugin.L3RouterPlugin

crudini --set /etc/neutron/plugin.ini ml2 mechanism_drivers openvswitch
crudini --set /etc/neutron/plugin.ini ml2 tenant_network_types vlan
crudini --set /etc/neutron/plugin.ini ml2 type_drivers vlan
crudini --set /etc/neutron/plugin.ini ml2_type_vlan network_vlan_ranges physnet1:1000:2000
crudini --set /etc/neutron/plugin.ini securitygroup firewall_driver neutron.agent.linux.iptables_firewall.OVSHybridIptablesFirewallDriver
crudini --set /etc/neutron/plugin.ini securitygroup enable_security_group True
crudini --set /etc/neutron/plugin.ini database sql_connection mysql://neutron:redhat@172.25.12.10/neutron
crudini --set /etc/neutron/plugin.ini ovs tenant_network_type vlan
crudini --set /etc/neutron/plugin.ini ovs bridge_mappings physnet1:br-ex

cp /etc/neutron/plugins/openvswitch/ovs_neutron_plugin.ini /etc/neutron/plugins/openvswitch/ovs_neutron_plugin.ini.orig
crudini --set /etc/neutron/plugins/openvswitch/ovs_neutron_plugin.ini ovs tenant_network_type vlan
crudini --set /etc/neutron/plugins/openvswitch/ovs_neutron_plugin.ini ovs network_vlan_ranges physnet1:1000:2000
crudini --set /etc/neutron/plugins/openvswitch/ovs_neutron_plugin.ini ovs bridge_mappings physnet1:br-ex
crudini --set /etc/neutron/plugins/openvswitch/ovs_neutron_plugin.ini securitygroup firewall_driver neutron.agent.linux.iptables_firewall.OVSHybridIptablesFirewallDriver

cp /etc/neutron/l3_agent.ini /etc/neutron/l3_agent.ini.orig
crudini --set /etc/neutron/l3_agent.ini DEFAULT interface_driver neutron.agent.linux.interface.OVSInterfaceDriver

cp /etc/neutron/dhcp_agent.ini /etc/neutron/dhcp_agent.ini.orig
crudini --set /etc/neutron/dhcp_agent.ini DEFAULT interface_driver neutron.agent.linux.interface.OVSInterfaceDriver
crudini --set /etc/neutron/dhcp_agent.ini DEFAULT ovs_use_veth True
