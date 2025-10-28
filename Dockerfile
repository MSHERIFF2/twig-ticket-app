# Stage 1: Build Stage (Used for installing dependencies)
FROM composer:2 AS composer_install

WORKDIR /app

# Copy composer files
COPY composer.json composer.lock /app/

# Install dependencies (will include Twig)
RUN composer install --no-dev --optimize-autoloader

# ---

# Stage 2: Final Stage (Lightweight runtime environment)
FROM php:8.2-fpm-alpine

WORKDIR /app

# Copy the installed vendor files from the build stage
COPY --from=composer_install /app/vendor /app/vendor

# Copy the rest of your application code (index.php, templates, assets)
COPY . /app

# ----------------------------------------------------
# ⬇️ RENDER FIXES ⬇️
# ----------------------------------------------------

# Expose a fixed port (Render often requires 8080 or 10000 for visibility)
EXPOSE 8080

# CRITICAL: Define the command to start the built-in PHP server.
# This replaces the Procfile for Docker deployments on Render.
# It explicitly binds to 8080, which Render's environment handles mapping to the external port.
CMD ["php", "-S", "0.0.0.0:8080", "-t", "public"]