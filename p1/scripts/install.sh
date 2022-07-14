#!/bin/bash

qemu-img create -f qcow2 /sgoinfre/goinfre/Perso/frthierr/iot.qcow2 30G

qemu-system-x86_64 -smp cores=2 \
				   -m 4G \
				   -nic user \
				   -boot d \
				   -cdrom /sgoinfre/goinfre/Perso/frthierr/archlinux-2022.07.01-x86_64.iso \
				   -hda /sgoinfre/goinfre/Perso/frthierr/iot.qcow2 \
				   -display gtk \
				   -enable-kvm