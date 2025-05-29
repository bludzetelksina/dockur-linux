#!/bin/bash
# Использование: ./create-disk.sh 10G /disk/vm-disk.img

DISK_SIZE="$1"
DISK_PATH="$2"

qemu-img create -f qcow2 "$DISK_PATH" "$DISK_SIZE"
