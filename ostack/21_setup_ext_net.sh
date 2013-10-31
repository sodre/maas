#!/bin/bash

echo 'Please visit http://m1basic-01.vm.maas/horizon/auth/login/?next=/horizon/project/access_and_security/api_access/openrc/'

echo 'and place the admin-openrc.sh file in the current directory'
echo 'Press any key once that is complete'

read

source admin-openrc.sh

neutron --os-tenant-name services net-delete ext_net 
neutron --os-tenant-name services net-create ext_net --router:external=True --provider:network_type=local
neutron --os-tenant-name services subnet-create ext_net 10.11.168.0/22 --dns-nameserver 10.11.7.11
