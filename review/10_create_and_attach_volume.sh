#!/usr/bin/env bash

source keystonerc_user1
volume_id=$(nova volume-create --display-name vol1 2 | grep "id" | head -n 1 | cut -d '|' -f 3 | tr -d '[[:space:]]')
nova volume-attach web $volume_id auto
