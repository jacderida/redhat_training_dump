mkdir /swap
dd if=/dev/zero of=/swap/file0 bs=1M count=4096
mkswap /swap/file0
vim /etc/fstab
swapon -a
chmod 600 /swap/file0
swapon -s
shutdown -h now
yum update -y
reboot
yum search rabbitmq
yum search rabbit
yum install -y rabbitmq-server.noarch

rabbitmqctl delete_user guest
rabbitmqctl add_user rabbitmqauth redhat
rabbitmqctl set_permissions rabbitmqauth ".*" ".*" ".*"
history | tail
;s
ls
rabbitmqctl set_user_tags rabbitmqauth administrator
history | tail
rabbitmqctl list_users
mkdir /etc/rabbitmq/testca
cd /etc/rabbitmq/testca/
mkdir certs private
ll
chmod 700 private
ll
echo 01 > serial.txt
cat serial.txt 
echo 01 > serial
rm serial.txt 
touch index.txt
wget -P /etc/rabbitmq/testca/ http://classroom.example.com
ll
rm index.html 
wget -P /etc/rabbitmq/testca/ http://classroom.example.com/materials/openssl.cnf
ll
history | tail
openssl req -x509 -config openssl.cnf -newkey rsa:2408 -days 365 -out cacert.pem -outform PEM -subj /CN=MyTestCA/ -nodes
openssl x509 -in cacert.pem -out cacert.cer -outform DER
mkdir -p /etc/rabbitmq/server
cd /etc/rabbitmq/server/
openssl genrsa -out key.pem 2048
openssl req -new -key key.pem -out req.pem -outform PEM -subj /CN=$(hostname)/0=server/ -nodes
history
cd /testca
cd ../testca/
openssl ca -config openssl.cnf -in ../server/req.pem -out ../server/cert.pem -notext -batch -extensions client_ca_extensions
cd ../server/
openssl pkcs12 -export -out keycert.p12 -in cert.pem -inkey key.pem -passout pass:MySecretPassword
history
cd ../testca/
cd
wget -P /etc/rabbitmq/ http://classroom.example.com/materials/rabbitmq.config
firewall-cmd --add-port=5672/tcp --permanent
firewall-cmd --add-port=5671/tcp --permanent
firewall-cmd --reload
systemctl restart rabbitmq-server
grep -i SSL /var/log/rabbitmq/*
netstat -nlp | grep 567[12]
systemctl enable rabbitmq-server
history
yum install -y openstack-keystone
yum install -y openstack-selinux
yum install -y openstack-utils
openstack-db --init --service keystone
openstack-db
openstack-db --init --service keystone -y
openstack-db
keystone-manage pki_setup --keystone-user keystone --keystone-group keystone
ll
vim keystone.sh 
bash keystone.sh 
ll
vim keystonerc_token
bash keystonerc_token 
source keystonerc_token 
crudini --set /etc/keystone/keystone.conf DEFAULT admin_token $SERVICE_TOKEN
systemctl start openstack-keystone
systemctl enable openstack-keystone
systemctl enable mariadb.service
firewall-cmd --add-port=35357/tcp --permanent
firewall-cmd --add-port=5000/tcp --permanent
firewall-cmd --reload
ps -ef | grep keystone-all
keystone service-create --name=keystone --type=identity --description="Keystone Identity Service"
keystone endpoint-create --service-id e9531ec0edfe462f81aa30d258b69069 --publicurl 'http://server12-a.example.com:5000/v2.0' --adminurl 'http://server12-a.example.com:35357/v2.0' --internalurl 'http://server12-a.example.com:5000/v2.0'
history
ll
keystone user-create --name admin --pass redhat
keystone role-create --name admin
keystone tenant-create --name admin
keystone user-role-add --user admin --role admin --tenant admin
vim keystonerc_admin
source keystonerc_admin 
keystone user-list
keystone user-create --name myuser --pass redhat
keystone role-create --name _member_
keystone keystone tenant-create --name myopenstack
keystone tenant-create --name myopenstack
keystone user-role-add --user myuser --role _member_ --tenant myopenstack
keystone user-role-list --user myuser --tenant myopenstack
ll
vim keystonerc_myuser
ll
rm keystonerc_myuser 
cp keystonerc_admin keystonerc_myuser
vim keystonerc_myuser 
source keystonerc_myuser 
keystone token-get --wrap 60
history
yum install -y openstack-swift-proxy
yum install -y openstack-swift-object
yum install -y openstack-swift-container
yum install -y openstack-swift-account
yum install -y python-swift
yum install -y python-swiftclient
yum install -y memcached
source /root/keystonerc_admin
keystone user-create --name swift --pass redhat
keystone role-list | grep "admin"
keystone tenant-list | grep "services"
keystone tenant-create --name services
keystone user-role-add --role admin --tenant services --user swift
keystone service-list | grep "swift"
keystone service-create --name swift --type object-store --description "Swift Storage Service"
keystone service-create
keystone endpoint-create --service-id 04291b9ac0c64036a79e7b677685e93d --publicurl "http://server12-a.example.com:8080/v1/AUTH_%(tenant_id)s" --adminurl "http://server12-a.example.com:8080/v1/AUTH_%(tenant_id)s" --internalurl "http://server12-a.example.com:8080/v1/AUTH_%(tenant_id)s"
keystone catalog
mkdir -p /srv/node/z{1,2}d1
cp /etc/fstab /etc/fstab.orig
echo "/dev/vdc1 /srv/node/z1d1 xfs defaults 0 0" >> /etc/fstab
echo "/dev/vdd1 /srv/node/z2d1 xfs defaults 0 0" >> /etc/fstab
history
mount -a
chown -R swift:swift /srv/node/
restorecon -vR /srv
cp /etc/swift/swift.conf /etc/swift/swift.conf.orig
cp /etc/swift/account-server.conf /etc/swift/account-server.conf.orig
cp /etc/swift/container-server.conf /etc/swift/container-server.conf.orig
cp /etc/swift/object-server.conf /etc/swift/object-server.conf.orig
crudini --set /etc/swift.conf swift-hash swift_hash_path_prefix $(openssl rand -hex 10)
crudini --set /etc/swift/swift.conf swift-hash swift_hash_path_prefix $(openssl rand -hex 10)
crudini --set /etc/swift/account-server.conf DEFAULT bind_ip 172.25.12.10
crudini --set /etc/swift/container-server.conf DEFAULT bind_ip 172.25.12.10
crudini --set /etc/swift/object-server.conf DEFAULT bind_ip 172.25.12.10
swift-ring-builder /etc/swift/account.builder create 12 2 1
swift-ring-builder /etc/swift/container.builder create 12 2 1
swift-ring-builder /etc/swift/object.builder create 12 2 1
ll
vim swift_rings.sh 
bash swift_rings.sh 
swift-ring-builder /etc/swift/account.builder rebalance
swift-ring-builder /etc/swift/container.builder rebalance
swift-ring-builder /etc/swift/object.builder rebalance
swift-ring-builder /etc/swift/object.builder search z1
vim swift_rings.sh 
bash swift_rings.sh 
vim swift_rings.sh 
swift-ring-builder /etc/swift/account.builder rebalance
swift-ring-builder /etc/swift/container.builder rebalance
swift-ring-builder /etc/swift/object.builder rebalance
vim swift_rings.sh 
ls /etc/swift/*gz
systemctl start openstack-swift-account
systemctl start openstack-swift-container
systemctl start openstack-swift-object
systemctl enable openstack-swift-account
systemctl enable openstack-swift-container
systemctl enable openstack-swift-object
chown -R root:swift /etc/swift
tail /var/log/messages 
ll
touch swift_proxy.sh
chmod a+x swift_proxy.sh 
vim swift_proxy.sh 
ll
bash swift_proxy.sh 
tail /var/log/messages 
swift list
swift post c1
swift post c2
swift list
head -c 1024 /dev/urandom > data.file ; swift upload c1 data.file
head -c 1024 /dev/urandom > data2.file ; swift upload c1 data2.file
head -c 1024 /dev/urandom > data3.file ; swift upload c2 data3.file
swift list c1
swift list c2
find /srv/node -type f -name "*data"
ll
touch swift_glance.sh
chmod a+x swift_glance.sh 
vim swift_glance.sh 
bash swift_glance.sh 
ll
mv swift_glance.sh glance.sh
ll
touch glance_conf.sh
chmod a+x glance_conf.sh 
vim glance_conf.sh 
bash glance_conf.sh 
egrep
touch glance_start.sh
chmod a+x glance_start.sh 
vim glance_start.sh 
bash glance_start.sh 
egrep 'ERROR|CRITICAL' /var/log/glance/*
keystone tenant-list
ll
touch glance_user.sh
chmod a+x glance_user.sh 
vim glance_user.sh 
bash glance_user.sh 
keystone endpoint-create --service-id 5551bc9b319b4106a17297c5c8d13d1e --publicurl http://server12-a.example.com:9292 --adminurl http://server12-a.example.com:9292 --internalurl http://server12-a.example.com:9292
vim glance_user.sh 
firewall-cmd --add-port=9292/tcp --permament
firewall-cmd --add-port=9292/tcp --permanent
firewall-cmd --reload
vim glance_user.sh 
ll
touch glance_image.sh
chmod a+x glance_image.sh 
vim glance_image.sh
bash glance_image.sh 
glance image-list
glance image-show small
ll
bash cinder.sh 
touch cinder_user.sh
vim cinder_user.sh 
chmod a+x cinder_user.sh
vim cinder_user.sh 
bash cinder_user.sh 
touch cinder_service.sh
chmod a+x cinder_service.sh 
vim cinder_service.sh 
bash cinder_service.sh 
vim cinder_service.sh 
keystone endpoint-create --service-id a10eb894a291440291547d6d90ccd31b --publicurl 'http://server12-a.example.com:8776/v1/%(tenant_id)s' --adminurl 'http://server12-a.example.com:8776/v1/%(tenant_id)s' --internalurl 'http://server12-a.example.com:8776/v1/%(tenant_id)s'
vim cinder_service.sh 
keystone service-create --name=cinderv2 --type=volume2 --description="OpenStack Block Storage Service v2"
vim cinder_service.sh 
keystone endpoint-create --service-id 125a4a7e1667421b9c9b0fb14af6ac0e --publicurl 'http://server12-a.example.com:8776/v2/%(tenant_id)s' --adminurl 'http://server12-a.example.com:8776/v2/%(tenant_id)s' --internalurl 'http://server12-a.example.com:8776/v2/%(tenant_id)s'
ll
touch cinder_conf.sh
chmod a+x cinder_conf.sh 
vim cinder_conf.sh 
bash cinder_conf.sh 
touch cinder_service.sh
chmod a+x cinder_service.sh 
vim cinder_service.sh 
touch cinder_start.sh
chmod a+x cinder_start.sh 
vim cinder_start.sh 
bash cinder_start.sh 
openstack-status
touch cinder_create_volume.sh
chmod a+x cinder_create_volume.sh 
vim cinder_create_volume.sh 
ll
vim cinder_create_volume.sh 
bash cinder_create_volume.sh 
vim cinder_create_volume.sh 
cinder create --display-name vol1 2
cinder list
cinder delete vol1
cinder delete e21787ff-7305-44e5-ae25-f86f5f9f7b08
cinder list
vim cinder_create_volume.sh 
ping -c 3 rhs.example.com
touch gluster.sh
chmod a+x gluster.sh 
vim gluster.sh 
bash gluster.sh 
ll
touch gluster_conf.sh
chmod a+x gluster_conf.sh 
vim gluster_conf.sh
df
cat gluster.sh 
glusterfs -s rhs.example.com --volfile-id=/volume12 /mnt/
df
umount /mnt/
vim gluster.sh 
ll
vim gluster_conf.sh 
df

vim gluster.sh 
vim gluster_conf.sh 
bash gluster_conf.sh 
touch gluster_service.sh
chmod a+x gluster_service.sh 
vim gluster_service.sh 
ll
vim gluster_service.sh 
bash gluster_service.sh 
tail /var/log/cinder/volume.log 
tail -f /var/log/cinder/volume.log 
cat /etc/cinder/cinder.conf
vim /etc/cinder/cinder.conf
ll
vim cinder_conf.sh 
bash cinder_conf.sh 
cat /etc/cinder/cinder.conf
openstack-service restart cinder
tail -f /var/log/cinder/volume.log 
ll
touch cinder_create_volume_types.sh
chmod a+x cinder_create_volume_types.sh 
vim cinder_create_volume
vim cinder_create_volume_types.sh 
bash cinder_create_volume_types.sh 
cinder type-list
ll
vim cinder_create_volume.sh 
touch cinder_create_alt_volumes.sh
chmod a+x cinder_create_alt_volumes.sh 
vim cinder_create_alt_volumes.sh 
bash cinder_create_alt_volumes.sh 
cinder list
cinder delete vol2
cinder delete vol3
cinder type-list
cinder type-delete lvm
cinder type-delete glusterfs
ls /etc/cinder
cp /etc/cinder/cinder.conf.orig /etc/cinder/cinder.conf
chown cinder:cinder /etc/cinder/cinder.conf
chmod 0600 /etc/cinder/cinder.conf
restorecon -v /etc/cinder/cinder.conf
openstack-service restart cinder
