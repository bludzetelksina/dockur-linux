FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

# Установка зависимостей (включая tzdata)
RUN apt update && apt install -y \
    tzdata \
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

# Настройка временной зоны — теперь tzdata уже установлена
RUN ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata

# Копируем noVNC
WORKDIR /opt
RUN git clone https://github.com/novnc/noVNC.git

# Копируем скрипты
COPY config/ /config/
RUN chmod +x /config/*.sh

EXPOSE 6080
