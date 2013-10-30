#!/bin/bash

juju set-constraints "arch=amd64 tags=m1basic"
juju deploy --config ostack.yaml keystone
juju add-relation keystone mysql
juju add-relation keystone ceph-radosgw 
juju add-relation openstack-dashboard keystone


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
juju add-relation cinder glance
juju add-relation cinder nova-cloud-controller


juju deploy --config ostack.yaml --repository . local:precise/quantum-gateway --constraints tags=neutron
juju add-relation quantum-gateway mysql
juju add-relation quantum-gateway rabbitmq-server
juju add-relation quantum-gateway nova-cloud-controller
