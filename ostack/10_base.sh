#!/bin/bash

## We assume at-least three nodes tagged ceph exist
juju deploy --config ostack.yaml -n 3 ceph --constraints tags=ceph 

juju set-constraints "arch=amd64 tags=m1basic"
juju deploy --config ostack.yaml openstack-dashboard

juju deploy --config ostack.yaml mysql
juju add-relation mysql ceph

juju deploy --config ostack.yaml rabbitmq-server
juju add-relation rabbitmq-server ceph

juju deploy --config ostack.yaml --repository . local:precise/ceph-radosgw
juju add-relation ceph-radosgw ceph
