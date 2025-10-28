# -----------------------------
# Stage 1: Build CSS with Node 
# -----------------------------
FROM node:20 AS build

WORKDIR /app

# 1. Copy package files (Critical for the install step)
COPY package*.json ./

# 2. Clean install dependencies (including dev)
# Clears cache and forces a fresh install to ensure the binary is placed correctly.
RUN npm cache clean --force && npm install --include=dev --force

# 3. Copy project files (input.css, tailwind.config.js, etc.)
COPY . .

# --- DIAGNOSTIC STEP ---
# This step confirms the binary is present and executable before the final run.
RUN ls -l ./node_modules/.bin/tailwindcss

# 4. Build Tailwind CSS 
# FINAL FIX: Uses the absolute path to 'npm' and the explicit 'exec' command 
# to run the locally installed 'tailwindcss' binary, bypassing all PATH issues.
RUN /usr/local/bin/npm exec tailwindcss -- -i ./public/css/input.css -o ./public/css/styles.css --minify


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