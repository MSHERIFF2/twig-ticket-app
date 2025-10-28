# # -----------------------------
# # Stage 1: Build CSS with Node 
# # -----------------------------
# FROM node:20 AS build

# WORKDIR /app

# # 1. Copy package files
# COPY package*.json ./

# # 2. Install dependencies (This installs the binaries into node_modules/.bin/)
# RUN npm install --include=dev

# # 3. Copy project files (Crucial for input.css and config files)
# COPY . .

# # 4. Build Tailwind CSS 
# # FINAL FIX: Use the absolute path to 'npm' to execute 'npx'
# RUN /usr/local/bin/npm exec tailwindcss -- -i ./public/css/input.css -o ./public/css/styles.css --minify


# # -----------------------------
# # Stage 2: PHP + Apache
# # -----------------------------
# FROM php:8.2-apache

# # Enable mod_rewrite for routing
# RUN a2enmod rewrite

# # Copy Composer binary from official image
# COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# WORKDIR /var/www/html

# # Copy all PHP app files 
# COPY . .

# # Copy built CSS from the 'build' stage
# COPY --from=build /app/public/css/styles.css ./public/css/styles.css

# # Install Composer dependencies
# RUN composer install --no-interaction --prefer-dist --optimize-autoloader

# # Fix permissions
# RUN chown -R www-data:www-data /var/www/html

# # Expose port
# EXPOSE 80

# # Start Apache
# CMD ["apache2-foreground"]