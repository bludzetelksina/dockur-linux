#!/bin/bash
# Использование: ./download-file.sh https://example.com/file.iso /disk/file.iso

URL="$1"
OUTPUT="$2"

# Проверка параметров
if [[ -z "$URL" || -z "$OUTPUT" ]]; then
  echo "Использование: $0 <url> <путь_сохранения>"
  exit 1
fi

# Скачиваем файл
curl -L "$URL" -o "$OUTPUT"

# Проверка результата
if [[ $? -eq 0 ]]; then
  echo "Файл успешно загружен: $OUTPUT"
else
  echo "Ошибка загрузки файла"
  exit 1
fi
