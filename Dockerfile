# -----------------------------
# Stage 1: Build CSS with Node
# -----------------------------
FROM node:20 AS build

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies (including dev)
# This installs tailwindcss into node_modules/.bin/
RUN npm install --include=dev

# REMOVE: RUN npm install -g tailwindcss

# Copy project files
COPY . .

# Build Tailwind CSS (Use npx to find the executable in node_modules/.bin)
RUN npx tailwindcss -i ./public/css/input.css -o ./public/css/styles.css --minify


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
# The built styles.css will now be successfully copied from the build stage.
COPY --from=build /app/public/css ./public/css

# Install Composer dependencies
RUN composer install --no-interaction --prefer-dist --optimize-autoloader

# Fix permissions
RUN chown -R www-data:www-data /var/www/html

# Expose port
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]