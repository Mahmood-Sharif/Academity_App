FROM php:8.2-apache

ENV APACHE_DOCUMENT_ROOT=/var/www/html/public
WORKDIR /var/www/html

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        git \
        unzip \
        libcurl4-openssl-dev \
        libicu-dev \
        libonig-dev \
        libxml2-dev \
        libzip-dev \
    && docker-php-ext-install curl intl mbstring mysqli pdo_mysql xml zip \
    && a2enmod rewrite headers \
    && sed -ri -e "s!/var/www/html!${APACHE_DOCUMENT_ROOT}!g" /etc/apache2/sites-available/*.conf \
    && printf "<Directory /var/www/html/public>\\n    AllowOverride All\\n    Require all granted\\n</Directory>\\n" > /etc/apache2/conf-available/academity.conf \
    && a2enconf academity \
    && rm -rf /var/lib/apt/lists/*

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

COPY composer.json composer.lock ./
RUN composer install \
    --no-dev \
    --prefer-dist \
    --no-interaction \
    --no-progress \
    --optimize-autoloader

COPY . .

RUN mkdir -p writable/cache writable/debugbar writable/logs writable/session writable/uploads \
    && chown -R www-data:www-data writable \
    && chmod -R ug+rwX writable

EXPOSE 80
