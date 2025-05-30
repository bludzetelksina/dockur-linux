#!/bin/bash
set -e

# Define the path to the disk image
DISK_IMAGE="/disk/vm-disk.img"

# Start the virtual machine using QEMU
qemu-system-x86_64 \
    -hda "$DISK_IMAGE" \
    -m 2048 \
    -smp 2 \
    -net nic -net user,hostfwd=tcp::2222-:22 \
    -vnc :0 \
    -enable-kvm
