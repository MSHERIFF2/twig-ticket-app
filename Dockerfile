## -----------------------------
# Stage 1: Build CSS with Node 
# -----------------------------
FROM node:20 AS build

WORKDIR /app

# 1. Copy package files (Now includes correct Tailwind version)
COPY package*.json ./

# 2. Install dependencies (This should now install the 'tailwindcss' binary correctly)
RUN npm install --include=dev

# 3. Copy project files (input.css, tailwind.config.js, etc.)
COPY . .

# 4. Build Tailwind CSS 
# Use the script defined in your package.json, which is the standard, reliable method.
# Your script uses 'npx', which correctly finds the local binary.
RUN npm run build:css




# -----------------------------
# Stage 2: PHP + Apache
# -----------------------------
FROM php:8.2-apache

# Enable mod_rewrite for routing
RUN a2enmod rewrite

# Copy Composer binary from official image
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

# Copy all PHP app files 
COPY . .

# Copy built CSS from the 'build' stage
# This file should now be correctly generated.
COPY --from=build /app/public/css/styles.css ./public/css/styles.css

# Install Composer dependencies
RUN composer install --no-interaction --prefer-dist --optimize-autoloader

# Fix permissions
RUN chown -R www-data:www-data /var/www/html

# Expose port
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]