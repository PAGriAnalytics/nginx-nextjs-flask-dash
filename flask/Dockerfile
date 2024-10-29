# Используйте официальный образ Python в качестве базового
FROM python:3.12-alpine

# Установите рабочую директорию в /app
WORKDIR /flask

# Скопируйте файл требований
COPY requirements.txt .

# Установите зависимости
RUN pip install --no-cache-dir -r requirements.txt

# Скопируйте код приложения
COPY . .

# Откройте порт, который будет использовать приложение Flask
EXPOSE 5000

# Запустите команду для старта приложения с помощью Gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]
