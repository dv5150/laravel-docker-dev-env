ARG NODE_VERSION
ARG PHP_VERSION
ARG PHP_INI

# Define Node version
FROM node:${NODE_VERSION}-alpine AS node

# Define PHP version
FROM php:${PHP_VERSION}-fpm-alpine

# Set up workspace
RUN mkdir -p /var/www/html
WORKDIR /var/www/html

# Set up user
RUN apk --no-cache add shadow && usermod -u 1000 www-data

# Set up custom PHP ini
ADD ./php/${PHP_INI} /usr/local/etc/php/php.ini

# [EXT] OPCache
ADD ./opcache/opcache.ini /usr/local/etc/php/conf.d/opcache.ini
RUN docker-php-ext-install opcache

# [EXT] Intl
RUN apk --no-cache add icu-dev
RUN docker-php-ext-install intl

# [EXT] Imagick
RUN apk --no-cache add autoconf g++ make imagemagick-dev imagemagick \
    && pecl install imagick \
    && docker-php-ext-enable imagick

# [EXt] ...others...
RUN docker-php-ext-install exif pdo pdo_mysql

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install Node
COPY --from=node /usr/lib /usr/lib
COPY --from=node /usr/local/share /usr/local/share
COPY --from=node /usr/local/lib /usr/local/lib
COPY --from=node /usr/local/include /usr/local/include
COPY --from=node /usr/local/bin /usr/local/bin

EXPOSE 8080
USER www-data:1000
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8080"]