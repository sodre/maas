#!/bin/sh

juju deploy --config ostack.yaml --repository . local:precise/nova-compute --constraints "arch=amd64 tags=cto7"
juju add-relation nova-compute nova-cloud-controller
juju add-relation nova-compute ceph
juju add-relation nova-compute mysql
juju add-relation nova-compute rabbitmq-server
juju add-relation nova-compute glance
