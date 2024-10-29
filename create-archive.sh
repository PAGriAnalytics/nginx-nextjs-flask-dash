#!/bin/bash

# Включаем dotglob для учета скрытых файлов и директорий
# shopt -s dotglob
# Запоминаем текущую директорию
CURRENT_DIR=$(pwd)
# Укажите папки и файлы, которые нужно исключить
EXCLUDE_DIRS=("./nextjs/node_modules" "./flask/__pycache__")
EXCLUDE_FILES=("./flask/Dockerfile" "./nginx/Dockerfile")

# Укажите файл, который нужно переименовать и добавить в архив
FILE_TO_RENAME="Dockerfile.all-in-one.prod"  # Укажите путь к файлу относительно текущей директории
NEW_FILE_NAME="Dockerfile"

# Создаем временную директорию для сборки
TEMP_DIR=$(mktemp -d)
if [[ ! -d "$TEMP_DIR" ]]; then
    echo "Failed to create temporary directory."
    exit 1
fi
# Удаляем временную директорию при выходе
trap 'rm -rf "$TEMP_DIR"' EXIT

# Функция для проверки наличия элемента в массиве
contains() {
    local item="$1"
    shift
    for element; do
        [[ "$element" == "$item" ]] && return 0
    done
    return 1
}
# Переименовываем файл и копируем его в временную директорию
if [[ -f "$FILE_TO_RENAME" ]]; then
    cp "$FILE_TO_RENAME" "$TEMP_DIR/$NEW_FILE_NAME" || { echo "Ошибка при копировании $FILE_TO_RENAME или удалении старого файла"; exit 1; }
else
    echo "Файл $FILE_TO_RENAME не найден."
    exit 1
fi
# Копируем директории и файлы, исключая указанные
for item in *; do
    if [ -d "$item" ]; then
        if ! contains "$item" "${EXCLUDE_DIRS[@]}"; then
            cp -r "$item" "$TEMP_DIR/" || { echo "Ошибка при копировании $item"; exit 1; }
        fi
    elif [ -f "$item" ]; then
        if ! echo "$item" | grep -qi '^docker'; then
            if ! contains "$item" "${EXCLUDE_FILES[@]}"; then
                cp "$item" "$TEMP_DIR/" || { echo "Ошибка при копировании $item"; exit 1; }
            fi
        fi
    fi
done


# Удаляем исключенные директории и файлы из временной директории
for exclude_dir in "${EXCLUDE_DIRS[@]}"; do
    rm -rf "$TEMP_DIR/${exclude_dir#./}" || { echo "Ошибка при удалении $exclude_dir"; exit 1; }
done

for exclude_file in "${EXCLUDE_FILES[@]}"; do
    rm -f "$TEMP_DIR/${exclude_file#./}" || { echo "Ошибка при удалении $exclude_file"; exit 1; }
done

# echo "Содержимое временной директории:"
# ls -la "$TEMP_DIR"

# Создаем архив
ARCHIVE_NAME="archive.zip"
cd "$TEMP_DIR" || { echo "Ошибка при переходе в временную директорию"; exit 1; }
zip -rq "$ARCHIVE_NAME" . || { echo "Ошибка при создании архива"; exit 1; }
echo "Архив $ARCHIVE_NAME успешно создан."
# Возвращаемся в исходную директорию
cd "$CURRENT_DIR"
# Перемещаем архив в исходную директорию
mv "$TEMP_DIR/$ARCHIVE_NAME" .
# # Создаем архив
# ARCHIVE_NAME="archive.tar.gz"
# tar -czf "$ARCHIVE_NAME" -C "$TEMP_DIR" . || { echo "Ошибка при создании архива"; exit 1; }
#
# echo "Архив $ARCHIVE_NAME успешно создан."
