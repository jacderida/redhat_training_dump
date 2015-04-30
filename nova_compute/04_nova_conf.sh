#!/usr/bin/env bash

source export_nova_conf_variables.sh
crudini --set $nova_api filter:authtoken admin_tenant_name services
crudini --set $nova_api filter:authtoken admin_user nova
crudini --set $nova_api filter:authtoken admin_password redhat
crudini --set $nova_api filter:authtoken auth_host 172.25.12.10
crudini --set $nova_api filter:authtoken identity_uri http://172.25.12.10:35357/
crudini --set $nova_conf DEFAULT rabbit_userid rabbitmqauth
crudini --set $nova_conf DEFAULT rabbit_password redhat
crudini --set $nova_conf DEFAULT rabbit_host server12-a.example.com
crudini --set $nova_conf DEFAULT rabbit_use_ssl True
crudini --set $nova_conf DEFAULT rabbit_port 5671
crudini --set $nova_conf DEFAULT novncproxy_base_url http://server12-a.example.com:6080/vnc_auto.html
crudini --set $nova_conf DEFAULT vncserver_listen 0.0.0.0
crudini --set $nova_conf DEFAULT glance_host 172.25.12.10
crudini --set $nova_conf DEFAULT metadata_host 172.25.12.10
crudini --set $nova_conf DEFAULT vncserver_proxyclient_address 172.25.12.10
crudini --set $nova_conf DEFAULT auth_strategy keystone
crudini --set $nova_conf DEFAULT verbose true
crudini --set $nova_conf libvirt vif_driver nova.virt.libvirt.vif.LibvirtGenericVIFDriver
crudini --set $nova_conf libvirt virt_type qemu
crudini --set $nova_conf libvirt cpu_mode none
crudini --set $nova_conf DEFAULT network_api_class nova.network.neutronv2.api.API
crudini --set $nova_conf DEFAULT neutron_admin_username neutron
crudini --set $nova_conf DEFAULT neutron_admin_password redhat
crudini --set $nova_conf DEFAULT neutron_admin_auth_url http://172.25.12.10:35357/v2.0/
crudini --set $nova_conf DEFAULT neutron_auth_strategy keystone
crudini --set $nova_conf DEFAULT neutron_admin_tenant_name services
crudini --set $nova_conf DEFAULT service_neutron_metadata_proxy true
crudini --set $nova_conf DEFAULT neutron_metadata_proxy_shared_secret redhat
crudini --set $nova_conf DEFAULT neutron_url http://172.25.12.10:9696/
crudini --set $nova_conf DEFAULT linuxnet_interface_driver nova.network.linux_net.LinuxOVSInterfaceDriver
crudini --set $nova_conf DEFAULT firewall_driver nova.virt.firewall.NoopFirewallDriver
crudini --set $nova_conf DEFAULT security_group_api neutron
crudini --set $nova_conf DEFAULT vif_plugging_is_fatal false
crudini --set $nova_conf DEFAULT vif_plugging_timeout 0
crudini --set $nova_conf DEFAULT cinder_catalog_info volume:cinder:internalURL
