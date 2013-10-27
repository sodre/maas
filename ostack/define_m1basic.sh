#!/bin/sh

id=$1

uuid=`uuidgen`

cp m1basic-00.xml.template m1basic-${id}.xml
sed -i -e "s/TEMPLATE_NAME/m1basic-${id}/" m1basic-${id}.xml
sed -i -e "s/TEMPLATE_UUID/${uuid}/" m1basic-${id}.xml
sed -i -e "s/TEMPLATE_MAC/52:54:00:00:01:${id}/" m1basic-${id}.xml

virsh --connect qemu+ssh://draco@10.11.11.1/system define m1basic-${id}.xml
