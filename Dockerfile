FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC


RUN cat /etc/apt/sources.list && apt update
# Установка только стабильных и доступных пакетов

RUN apt update && apt install -y tzdata

RUN apt update && apt install -y wget

RUN apt update && apt install -y curl

RUN apt update && apt install -y sudo

RUN apt update && apt install -y net-tools

RUN apt update && apt install -y git

RUN apt update && apt install -y xvfb

RUN apt update && apt install -y fluxbox

RUN apt update && apt install -y && rm -rf /var/lib/apt/lists/*

# Настройка временной зоны
RUN ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata

# Клонируем noVNC вручную
WORKDIR /opt
RUN git clone https://github.com/novnc/noVNC.git

# Установка websockify через pip (вместо apt)
RUN apt update && apt install -y python3 python3-pip && \
    pip3 install websockify

# Копируем скрипты
COPY config/ /config/
RUN chmod +x /config/*.sh

EXPOSE 6080
