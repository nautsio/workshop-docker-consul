#!/bin/sh

cd docker-consul-host
vagrant ssh -c "ifconfig eth1" -- -q | grep 'inet addr:' | awk -F: '{print $2}' | awk '{print $1}'