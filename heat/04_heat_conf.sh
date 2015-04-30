#!/usr/bin/env bash

export ENCKEY=$(openssl rand -hex 16)
crudini --set /etc/heat/heat.conf DEFAULT rabbit_host server12-a.example.com
crudini --set /etc/heat/heat.conf heat_api bind_host 172.25.12.10
crudini --set /etc/heat/heat.conf heat_api_cfn bind_host 172.25.12.10
crudini --set /etc/heat/heat.conf heat_api_cloudwatch bind_host 172.25.12.10
crudini --set /etc/heat/heat.conf DEFAULT heat_metadata_server_url 172.25.12.10:8000
crudini --set /etc/heat/heat.conf DEFAULT heat_waitcondition_server_url 172.25.12.10:8000/v1/waitcondition
crudini --set /etc/heat/heat.conf DEFAULT heat_watch_server_url 172.25.12.10:8003
