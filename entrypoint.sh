#!/bin/bash

set -e

ISO_PATH="/qemu/linux.iso"
DISK_PATH="/qemu/vm.qcow2"
DISK_SIZE="10G"
NOVNC_DIR="/novnc"
VNC_PORT=":1"
WEBSOCKET_PORT="6080"

echo "[INFO] Проверка наличия ISO-образа..."
if [ ! -f "$ISO_PATH" ]; then
    echo "[ERROR] ISO-файл не найден: $ISO_PATH"
    echo "Поместите ISO в папку /qemu или добавьте загрузку в download.sh"
    exit 1
fi

echo "[INFO] Проверка диска виртуальной машины..."
if [ ! -f "$DISK_PATH" ]; then
    echo "[INFO] Диск не найден. Создание нового $DISK_SIZE QCOW2-диска..."
    qemu-img create -f qcow2 "$DISK_PATH" "$DISK_SIZE"
else
    echo "[INFO] Диск уже существует: $DISK_PATH"
fi

echo "[INFO] Запуск виртуальной машины через QEMU..."
# QEMU запускается в фоновом режиме с VNC на :1
qemu-system-x86_64 \
    -m 2048 \
    -smp 2 \
    -enable-kvm \
    -cdrom "$ISO_PATH" \
    -hda "$DISK_PATH" \
    -boot d \
    -vnc $VNC_PORT \
    -net nic -net user \
    -name "dockur-vm" &

echo "[INFO] Ожидание 2 секунды перед запуском noVNC..."
sleep 2

echo "[INFO] Запуск websockify (noVNC) на порту $WEBSOCKET_PORT..."
/usr/bin/websockify --web="$NOVNC_DIR" "$WEBSOCKET_PORT" localhost:5901 &

echo "[SUCCESS] VM и noVNC запущены. Перейдите в браузере по адресу:"
echo "          http://localhost:$WEBSOCKET_PORT/vnc.html"

# Ожидаем завершения процессов
wait
