# -----------------------------
# Stage 1: Build CSS with Node
# -----------------------------
FROM node:20 AS build

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies (including dev)
RUN npm install --include=dev

# Install Tailwind CLI globally so it's always accessible
RUN npm install -g tailwindcss

# Copy project files
COPY . .

# Build Tailwind CSS (no npx confusion)
RUN tailwindcss -i ./public/css/input.css -o ./public/css/styles.css --minify


# -----------------------------
# Stage 2: PHP + Apache
# -----------------------------
FROM php:8.2-apache

# Enable mod_rewrite for routing
RUN a2enmod rewrite

# Copy Composer binary from official image
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

# Copy all app files from build stage
COPY . .

# Copy built CSS
COPY --from=build /app/public/css ./public/css

# Install Composer dependencies
RUN composer install --no-interaction --prefer-dist --optimize-autoloader

# Fix permissions
RUN chown -R www-data:www-data /var/www/html

# Expose port
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]
