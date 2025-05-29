#!/bin/bash
# Запускаем noVNC и VM

/websockify --web=/opt/noVNC 6080 localhost:5901 &

# Графическое окружение
Xvfb :1 -screen 0 1024x768x16 &
DISPLAY=:1 fluxbox &

# Запуск виртуальной машины
qemu-system-x86_64 \
  -m 2048 \
  -hda /disk/vm-disk.img \
  -vnc :1 \
  -enable-kvm
