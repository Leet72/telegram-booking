#!/bin/bash
echo "🚀 Начинаем деплой Telegram WebApp!"

# Обновляем сервер
sudo apt update && sudo apt upgrade -y

# Устанавливаем Node.js, MongoDB и Nginx
sudo apt install -y nodejs npm nginx mongodb-org

# Запуск MongoDB
sudo systemctl start mongod
sudo systemctl enable mongod

# Клонируем проект и устанавливаем зависимости
git clone https://github.com/YOUR_GITHUB_USERNAME/telegram-booking.git
cd telegram-booking/backend
npm install
cd ../frontend
npm install
npm run build

# Настраиваем Nginx
sudo cp ../nginx/telegram-booking.conf /etc/nginx/sites-available/
sudo ln -s /etc/nginx/sites-available/telegram-booking.conf /etc/nginx/sites-enabled/
sudo systemctl restart nginx

# Запуск бэкенда
cd ../backend
nohup node server.js > backend.log 2>&1 &

echo "✅ Telegram WebApp успешно развернут!"
