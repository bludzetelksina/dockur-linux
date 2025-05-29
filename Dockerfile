FROM ubuntu:22.04

RUN apt update && apt install -y \
    qemu-kvm \
    wget \
    curl \
    sudo \
    net-tools \
    git \
    x11vnc \
    xvfb \
    fluxbox \
    novnc \
    websockify \
    && rm -rf /var/lib/apt/lists/*

# Копируем noVNC (можно клонировать вручную)
WORKDIR /opt
RUN git clone https://github.com/novnc/noVNC.git

# Копируем скрипты
COPY config/ /config/
RUN chmod +x /config/*.sh

EXPOSE 6080
