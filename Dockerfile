FROM php:5.6-fpm-alpine

RUN apk add --no-cache \
    mysql-client \
    libpng-dev \
    libjpeg-turbo-dev \
    libzip-dev \
    curl \
    && docker-php-ext-configure gd --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd mbstring pdo_mysql zip

RUN echo "expose_php = Off" >> /usr/local/etc/php/conf.d/docker-php-expose.ini

WORKDIR /var/www/html

COPY . /var/www/html

RUN chown -R www-data:www-data /var/www/html \
    && find /var/www/html -type d -exec chmod 755 {} \; \
    && find /var/www/html -type f -exec chmod 644 {} \;

COPY . /var/www/html

EXPOSE 9000

CMD ["php-fpm"]
