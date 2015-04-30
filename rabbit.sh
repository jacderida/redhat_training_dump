#!/usr/bin/env bash

function install_rabbit() {
    yum install -y rabbitmq-server
    systemctl start rabbitmq-server
    rabbitmqctl delete_user guest
    rabbitmqctl add_user rabbitmqauth redhat
    rabbitmqctl set_permissions rabbitmqauth ".*" ".*" ".*"
    rabbitmqctl set_user_tags rabbitmqauth administrator
}

function setup_ssl() {
    mkdir /etc/rabbitmq/testca
    cd /etc/rabbitmq/testca
    mkdir certs private
    echo 01 > serial
    touch index.txt
    wget -P /etc/rabbitmq/testca/ http://classroom.example.com/materials/openssl.cnf
    openssl req -x509 -config openssl.cnf -newkey rsa:2408 -days 365 -out cacert.pem -outform PEM -subj /CN=MyTestCA/ -nodes
    openssl x509 -in cacert.pem -out cacert.cer -outform DER
    mkdir -p /etc/rabbitmq/server
    cd /etc/rabbitmq/server/
    openssl genrsa -out key.pem 2048
    openssl req -new -key key.pem -out req.pem -outform PEM -subj /CN=$(hostname)/0=server/ -nodes
    cd ../testca/
    openssl ca -config openssl.cnf -in ../server/req.pem -out ../server/cert.pem -notext -batch -extensions client_ca_extensions
    cd ../server/
    openssl pkcs12 -export -out keycert.p12 -in cert.pem -inkey key.pem -passout pass:MySecretPassword
}

function get_config_file() {
    wget -P /etc/rabbitmq/ http://classroom.example.com/materials/rabbitmq.config
}

function setup_firewall() {
   firewall-cmd --add-port=5672/tcp --permanent
   firewall-cmd --add-port=5671/tcp --permanent
   firewall-cmd --reload
}

function setup_server() {
   systemctl restart rabbitmq-server
   systemctl enable rabbitmq-server
}

install_rabbit
setup_ssl
get_config_file
setup_firewall
setup_server
