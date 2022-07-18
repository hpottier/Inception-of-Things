#!/bin/bash

qemu-system-x86_64 -smp cores=2 \
				   -m 4G \
				   -nic user \
				   -hda /sgoinfre/goinfre/Perso/$(whoami)/iot.qcow2 \
				   -display gtk \
				   -accel hvf \
				   -cpu host \
				   -enable-kvm
