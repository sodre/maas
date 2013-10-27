#!/bin/bash

## We assume at-least three nodes tagged ceph exist
juju deploy --config ostack.yaml -n 3 ceph --constraints tags=ceph 

juju set-constraints "arch=amd64 tags=m1basic"

juju deploy --config ostack.yaml mysql
juju add-relation mysql ceph

juju deploy --config ostack.yaml rabbitmq-server
juju add-relation rabbitmq-server ceph

# We 
echo 'Press any key _AFTER_ mysql and ceph are connected'
read
juju deploy --config ostack.yaml keystone
juju add-relation keystone mysql

juju deploy --config ostack.yaml ceph-radosgw
juju add-relation ceph-radosgw ceph
juju add-relation ceph-radosgw keystone

juju deploy --config ostack.yaml nova-cloud-controller
juju add-relation nova-cloud-controller mysql
juju add-relation nova-cloud-controller rabbitmq-server
juju add-relation nova-cloud-controller keystone

juju deploy --config ostack.yaml glance
juju add-relation glance ceph
juju add-relation glance mysql
juju add-relation glance keystone
juju add-relation glance nova-cloud-controller


juju deploy --config ostack.yaml cinder 
juju add-relation cinder ceph
juju add-relation cinder mysql
juju add-relation cinder rabbitmq-server
juju add-relation cinder keystone
juju add-relation cinder nova-cloud-controller
juju add-relation cinder glance

juju deploy --config ostack.yaml openstack-dashboard
juju add-relation openstack-dashboard keystone


juju deploy --config ostack.yaml quantum-gateway --constraints tags=neutron

echo 'You need to configure eth1 on the quantum gateway...'
echo 'Press any key when quantum-gateway/0 has received and ip address'
read
juju ssh quantum-gateway/0

juju add-relation quantum-gateway mysql
juju add-relation quantum-gateway rabbitmq-server
juju add-relation quantum-gateway nova-cloud-controller


