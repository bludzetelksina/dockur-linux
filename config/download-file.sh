#!/bin/bash
# Использование: ./download-file.sh https://example.com/file.iso /disk/file.iso

VERSION="$1"
DOWNLOAD="$2"

wget "$VERSION" -O "$DOWNLOAD"
