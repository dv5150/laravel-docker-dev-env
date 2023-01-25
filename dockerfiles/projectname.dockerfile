# Install PHP
FROM php:8.2.1-fpm-alpine AS php

# Set up workspace
RUN mkdir -p /var/www/html
WORKDIR /var/www/html

# Install PHP extensions
RUN docker-php-ext-install pdo pdo_mysql

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install Node
COPY --from=node:18.6.0-alpine /usr/lib /usr/lib
COPY --from=node:18.6.0-alpine /usr/local/share /usr/local/share
COPY --from=node:18.6.0-alpine /usr/local/lib /usr/local/lib
COPY --from=node:18.6.0-alpine /usr/local/include /usr/local/include
COPY --from=node:18.6.0-alpine /usr/local/bin /usr/local/bin

# Copy this file and use different ports for each project
EXPOSE 8081
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8081"]