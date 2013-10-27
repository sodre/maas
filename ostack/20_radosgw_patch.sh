#!/bin/bash

juju ssh ceph-radosgw/0 sudo mkdir /var/lib/ceph/radosgw/ceph-radosgw.gateway
juju ssh ceph-radosgw/0 sudo touch /var/lib/ceph/radosgw/ceph-radosgw.gateway/done
juju ssh ceph-radosgw/0 sudo start radosgw-all-starter


echo 'You need to fix dashboard/swift api'
echo 'https://review.openstack.org/#/c/36811/'
echo 'http://permalink.gmane.org/gmane.comp.file-systems.ceph.devel/15691'

juju ssh openstack-dashboard/0
