FROM ubuntu:22.04

RUN apt update && apt install -y \
    qemu-kvm wget curl git novnc websockify \
    && rm -rf /var/lib/apt/lists/*

COPY qemu /qemu/
COPY utils /utils/
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh /utils/*.sh /qemu/*.sh

WORKDIR /qemu

RUN git clone https://github.com/novnc/noVNC.git /novnc

EXPOSE 6080

ENTRYPOINT ["/entrypoint.sh"]
