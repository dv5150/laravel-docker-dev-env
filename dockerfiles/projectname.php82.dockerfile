FROM php:8.2.1-fpm-alpine

RUN mkdir -p /var/www/html

WORKDIR /var/www/html

RUN docker-php-ext-install pdo pdo_mysql

RUN apk --no-cache add pcre-dev ${PHPIZE_DEPS} \
    && pecl install redis \
    && docker-php-ext-enable redis \
    && apk del pcre-dev ${PHPIZE_DEPS}

# Copy this file and use different ports for each project
EXPOSE 8081
CMD ["/usr/local/bin/php", "artisan", "serve", "--host=0.0.0.0", "--port=8081"]