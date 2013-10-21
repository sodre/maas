#!/bin/bash

old=`hostname`

hostname $1

sed -i "s/$old/$1/g" /etc/hosts
sed -i "s/$old/$1/g" /etc/hostname 

