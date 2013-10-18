#!/bin/bash

sed --in-place=.back "s/DEFAULT_FORWARD_POLICY=\"DROP\"/DEFAULT_FORWARD_POLICY=\"ACCEPT\"/" /etc/default/ufw
sed --in-place=.back "s/\#net\/ipv4\/ip_forward/net\/ipv4\/ip_forward/" /etc/ufw/sysctl.conf

cat >> /etc/ufw/before.rules << EOL

# IP Masquerading
# nat Table rules
*nat
:POSTROUTING ACCEPT [0:0]

# Forward traffic from eth1 through eth0.
-A POSTROUTING -s 10.64.0.0/24 -o eth0 -j MASQUERADE

# don't delete the 'COMMIT' line or these nat table rules won't be processed
COMMIT

EOL

ufw allow ssh
ufw disable 
ufw enable
