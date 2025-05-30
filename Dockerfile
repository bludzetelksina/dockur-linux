# Use a base image with the necessary tools
FROM ubuntu:20.04

# Set environment variables to avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update package list and install necessary packages
RUN apt-get update && apt-get install -y qemu-kvm

RUN apt-get update && apt-get install -y libvirt-daemon-system

RUN apt-get update && apt-get install -y libvirt-clients

RUN apt-get update && apt-get install -y bridge-utils

RUN apt-get update && apt-get install -y virt-manager

RUN apt-get update && apt-get install -y wget

RUN apt-get update && apt-get clean

RUN apt-get update && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy the configuration scripts into the image
COPY config/ /app/config/

# Make the scripts executable
RUN chmod +x /app/config/*.sh

# Expose any necessary ports (e.g., for VNC or other services)
EXPOSE 5900

# Define the default command to run your VM start script
CMD ["/app/config/vm-start.sh"]
