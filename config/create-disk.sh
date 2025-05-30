#!/bin/bash
set -e

# Define the path and size for the disk image
DISK_IMAGE="/disk/vm-disk.img"
DISK_SIZE="10G"

# Create the disk image using qemu-img
qemu-img create -f qcow2 "$DISK_IMAGE" "$DISK_SIZE"
