#!/bin/bash

apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -yqq \
    libmcrypt-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng12-dev \
    libssl-dev \
    libicu-dev \
    libbz2-dev \
    && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) \
        imap \
        gd \
        mcrypt \
        mbstring \
        pdo_mysql \
        opcache \
        intl \
        zip \
        bz2 \
        gmp \
        bcmath

# MONGO, xdebug and other extensions
pecl install redis mongodb xdebug-2.5.1 apcu \
  && docker-php-ext-enable redis mongodb xdebug apcu
