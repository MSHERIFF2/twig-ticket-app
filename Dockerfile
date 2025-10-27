# -----------------------------
# Stage 1: Build CSS with Node
# -----------------------------
FROM node:20 AS build

WORKDIR /app

# Copy package files
COPY package*.json ./

# Force devDependencies installation (includes Tailwind)
RUN npm install --include=dev

# Copy all source files (for Tailwind input/output)
COPY . .

# Build Tailwind CSS (compile once, not watch)
RUN npx tailwindcss -i ./public/css/input.css -o ./public/css/styles.css --minify


# -----------------------------
# Stage 2: PHP + Apache
# -----------------------------
FROM php:8.2-apache

# Enable Apache mod_rewrite for clean URLs
RUN a2enmod rewrite

# Copy Composer binary from official image
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www/html

# Copy project files from Node build stage
COPY . .

# Copy built CSS from previous stage
COPY --from=build /app/public/css ./public/css

# Install Composer dependencies (safe for Twig)
RUN composer install --no-interaction --prefer-dist --optimize-autoloader

# Fix permissions
RUN chown -R www-data:www-data /var/www/html

# Expose port 80
EXPOSE 80

# Start Apache server
CMD ["apache2-foreground"]
