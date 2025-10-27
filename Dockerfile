# Use the official PHP image with Apache
FROM php:8.2-apache

# Enable Apache mod_rewrite (needed for routing)
RUN a2enmod rewrite

# Copy your project files into the container
COPY . /var/www/html/

# Set working directory
WORKDIR /var/www/html/

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Install PHP dependencies
RUN composer install --no-interaction --no-scripts --no-autoloader
RUN composer dump-autoload --optimize

# Install Node and Tailwind for CSS build
RUN apt-get update && apt-get install -y curl gnupg && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    npm install && npm run build:css

# Expose port 80
EXPOSE 80

# Start Apache server
CMD ["apache2-foreground"]
