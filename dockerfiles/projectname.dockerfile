# Install PHP
FROM php:8.2.1-fpm-alpine

# Set up workspace
RUN mkdir -p /var/www/html
WORKDIR /var/www/html

# Set up user
RUN apk --no-cache add shadow && usermod -u 1000 www-data

# Install PHP extensions
RUN apk add icu-dev
RUN docker-php-ext-install exif intl pdo pdo_mysql

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
USER www-data:1000
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8081"]