#!/bin/bash
set -e -x

# пример содержимого
qemu-img create -f qcow2 disk/vm-disk.img 10G
