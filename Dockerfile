# PHP Docker image for Yii 2.0 Framework runtime
# ==============================================

FROM php:7.1

# Install system packages for PHP extensions recommended for Yii 2.0 Framework
RUN curl -sL https://deb.nodesource.com/setup_4.x | bash - && \
    apt-key update && \
    apt-get update && \
    apt-get -y install \
            g++ \
            git \
            libicu-dev \
            libmcrypt-dev \
            libfreetype6-dev \
            libjpeg-dev \
            libjpeg62-turbo-dev \
            libmcrypt-dev \
            libpng12-dev \
            zlib1g-dev \
            mysql-client \
            openssh-client \
            libxml2-dev \
            nano \
            yui-compressor \
            linkchecker \
            nodejs \
        --no-install-recommends && \
        apt-get clean && \
        npm -g install npm@latest && \
        rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install PHP extensions required for Yii 2.0 Framework
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/ && \
    docker-php-ext-configure bcmath && \
    docker-php-ext-install gd \
                           intl \
                           pdo_mysql \
                           pdo_pgsql \
                           mbstring \
                           mcrypt \
                           opcache \
                           zip \
                           bcmath \
                           soap
RUN pecl install amqp \
    && docker-php-ext-enable amqp

RUN apt-get install -yqq git
