#!/usr/bin/env bash

mkdir -p /srv/node/z{1,2}d1
cp /etc/fstab /etc/fstab.orig
echo "/dev/vdc1 /srv/node/z1d1 xfs defaults 0 0" >> /etc/fstab
echo "/dev/vdd1 /srv/node/z2d1 xfs defaults 0 0" >> /etc/fstab
mount -a
chown -R swift:swift /srv/node/
restorecon -vR /srv
cp /etc/swift/swift.conf /etc/swift/swift.conf.orig
cp /etc/swift/account-server.conf /etc/swift/account-server.conf.orig
cp /etc/swift/container-server.conf /etc/swift/container-server.conf.orig
cp /etc/swift/object-server.conf /etc/swift/object-server.conf.orig
crudini --set /etc/swift/swift.conf swift-hash swift_hash_path_prefix $(openssl rand -hex 10)
crudini --set /etc/swift/swift.conf swift-hash swift_hash_path_suffix $(openssl rand -hex 10)
crudini --set /etc/swift/account-server.conf DEFAULT bind_ip 172.25.12.10
crudini --set /etc/swift/container-server.conf DEFAULT bind_ip 172.25.12.10
crudini --set /etc/swift/object-server.conf DEFAULT bind_ip 172.25.12.10
