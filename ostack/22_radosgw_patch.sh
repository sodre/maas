#!/bin/bash

echo 'You need to fix dashboard/swift api'
echo 'First you need to add gitbuilder.ceph.com to squid-deb-proxy on MAAS Region Controller'
echo 'http://askubuntu.com/questions/303150/apt-get-403-forbidden-but-accessible-in-the-browser'
echo 'Press any key once that has been done'

read

echo 'Generating the nss folder as described, in http://ceph.com/docs/master/radosgw/config/; Also need to change ceph.conf'
echo http://ceph.com/docs/master/radosgw/config/
echo

juju ssh ceph-radosgw/0 sudo apt-get install -y libnss3-tools

juju ssh keystone/0 sudo openssl x509 -in /etc/keystone/ssl/certs/ca.pem -pubkey | \
  juju ssh ceph-radosgw/0 sudo certutil -d /var/lib/ceph/nss -A -n ca -t "TCu,Cu,Tuw"

juju ssh keystone/0 sudo openssl x509 -in /etc/keystone/ssl/certs/signing_cert.pem -pubkey | \
  juju ssh ceph-radosgw/0 sudo certutil -A -d /var/lib/ceph/nss -n signing_cert -t "P,P,P"

juju ssh ceph-radosgw/0 << 'EOF'
  sudo sed -i -e 's/\#nss/ nss/' /etc/ceph/ceph.conf 
	sudo mkdir /var/lib/ceph/radosgw/ceph-radosgw.gateway
	sudo touch /var/lib/ceph/radosgw/ceph-radosgw.gateway/done
  sudo service radosgw-all-starter restart
	sudo service apache2  restart
EOF

