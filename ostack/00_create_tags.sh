#!/bin/sh

maas-cli draco tag delete juju
maas-cli draco tags new  				\
	name="juju"                                   	\
	comment="A potential bootstrap node" 		\
	definition='//node[starts-with(@id,"juju")]'


maas-cli draco tag delete ceph
maas-cli draco tags new  				\
	name="ceph"                                   	\
	comment="A potential Ceph node" 		\
	definition='//node[starts-with(@id,"ceph")]'

maas-cli draco tag delete m1basic
maas-cli draco tags new  				\
	name="m1basic"                                	\
	comment="Node with 1G-2G RAM and 8GB HD" 	\
	definition='//node[starts-with(@id,"m1basic")]'

maas-cli draco tag delete neutron
maas-cli draco tags new  				\
	name="neutron"                                	\
	comment="A potential neutron node" 		\
	definition='//node[starts-with(@id,"neutron")]'

maas-cli draco tag delete cto7
maas-cli draco tags new  				\
	name="cto7"                                	\
	comment="A trusty CTO7 Machine" 		\
	definition='//node[starts-with(@id,"cto7")]'


