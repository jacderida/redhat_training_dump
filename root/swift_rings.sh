#!/usr/bin/env bash

source /root/keystonerc_admin
rm -rf /etc/swift/account.builder*
rm -rf /etc/swift/container.builder*
rm -rf /etc/swift/object.builder*
swift-ring-builder /etc/swift/account.builder create 12 2 1
swift-ring-builder /etc/swift/container.builder create 12 2 1
swift-ring-builder /etc/swift/object.builder create 12 2 1

for i in 1 2; do
    swift-ring-builder /etc/swift/account.builder add z${i}-172.25.12.10:6002/z${i}d1 100
done
for i in 1 2; do
    swift-ring-builder /etc/swift/container.builder add z${i}-172.25.12.10:6001/z${i}d1 100
done
for i in 1 2; do
    swift-ring-builder /etc/swift/object.builder add z${i}-172.25.12.10:6000/z${i}d1 100
done

swift-ring-builder /etc/swift/account.builder create 12 2 1
swift-ring-builder /etc/swift/container.builder create 12 2 1
swift-ring-builder /etc/swift/object.builder create 12 2 1
