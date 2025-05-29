#!/bin/bash
# Запускаем noVNC и VM

# Прокси VNC через WebSocket для браузера
/websockify --web=/opt/noVNC 6080 localhost:5901 &

# Запуск графической среды
Xvfb :1 -screen 0 1024x768x16 &
sleep 2
DISPLAY=:1 fluxbox &

# Запуск виртуальной машины
qemu-system-x86_64 \
  -m 2048 \
  -hda /disk/vm-disk.img \
  -vnc :1 \
  -enable-kvm

# Вывод URL
echo "Открой в браузере: http://localhost:6080/vnc.html"

# Ждём завершения фоновых процессов (опционально)
wait
