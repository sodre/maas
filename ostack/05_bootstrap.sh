#!/bin/sh

juju bootstrap -e draco --constraints "arch=amd64 tags=juju" --show-log
