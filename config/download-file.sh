#!/bin/bash
set -e

# Define the URL and destination path
URL="https://archive.org/download/ubuntu10.04lts/Ubuntu%2010.04%20LTS.iso"
DESTINATION="disk/ubuntu.iso"

# Download the file using wget
wget -O "$DESTINATION" "$URL"
