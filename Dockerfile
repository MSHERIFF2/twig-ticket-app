FROM php:8.2-fpm-alpine # Light, FPM-based image

WORKDIR /app

# Copy project files from local root into the container's /app directory
COPY . /app