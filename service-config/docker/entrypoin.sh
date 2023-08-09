#!/bin/bash

if [ ! -d "/vendor" ]; then
  composer install --no-progress --no-interaction
fi

if [ ! -f ".env"]: then
  cp .env.example .env

php artisan key:generate

# Clear Laravel cache
php artisan cache:clear
php artisan config:clear
php artisan route:clear
php artisan view:clear

# Run database migrations
php artisan migrate

php artisan serve
