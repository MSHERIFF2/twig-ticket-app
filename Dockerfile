# -----------------------------
# Stage 1: Build CSS with Node
# -----------------------------
FROM node:20 AS build

# Set working directory
WORKDIR /app

# Copy only package files first (for caching)
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy all project files (for Tailwind build)
COPY . .

# Build CSS
RUN npm run build:css


# -----------------------------
# Stage 2: PHP + Apache
# -----------------------------
FROM php:8.2-apache

# Enable Apache mod_rewrite (for clean URLs)
RUN a2enmod rewrite

# Install required PHP extensions (optional but safe)
RUN docker-php-ext-install pdo pdo_mysql

# Copy Composer from official image
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www/html

# Copy project files from Node build stage
COPY . .

# Copy the built CSS from previous stage
COPY --from=build /app/public/css ./public/css

# Install Composer dependencies
RUN composer install --no-interaction --prefer-dist --optimize-autoloader

# Ensure Apache has correct permissions
RUN chown -R www-data:www-data /var/www/html

# Expose web port
EXPOSE 80

# Start Apache server
CMD ["apache2-foreground"]
