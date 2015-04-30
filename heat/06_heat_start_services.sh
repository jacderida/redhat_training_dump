#!/usr/bin/env bash

source ../keystonerc_admin
chown -R heat:heat /var/log/heat
runuser -s /bin/sh heat -c "heat-manage db_sync"
systemctl start openstack-heat-api
systemctl start openstack-heat-api-cfn
systemctl start openstack-heat-api-cloudwatch
systemctl start openstack-heat-engine
systemctl enable openstack-heat-api
systemctl enable openstack-heat-api-cfn
systemctl enable openstack-heat-api-cloudwatch
systemctl enable openstack-heat-engine
