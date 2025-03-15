FROM php:8.3-fpm AS php83
RUN apt-get update \
    && apt-get install -y \
        curl \
        git \        
        libicu-dev \
        libonig-dev \
        libpng-dev \
        libpq-dev \
        libxml2-dev \
        libzip-dev \
        net-tools \
        telnet \
        unzip \
        zip \
    && apt-get clean && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-install \
    pdo_pgsql \
        pgsql \
        pdo_pgsql \    
        pdo \
        mbstring \
        exif \
        pcntl \
        bcmath \
        gd \
        intl \
        zip \
        opcache \
    && pecl install redis && docker-php-ext-enable redis \
    && pecl install xdebug && docker-php-ext-enable xdebug
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
WORKDIR /var/www
CMD ["php-fpm"]
EXPOSE 9000

FROM php83 AS dev 
RUN apt-get update && apt-get install -y \
    libfreetype6-dev  \
    libxext6 \
    libxi-dev  \
    libxrender-dev \
    libxtst6  \        
    openjdk-17-jdk \
    procps  \
    && apt-get clean && rm -rf /var/lib/apt/lists/*
ADD https://deb.nodesource.com/setup_23.x nodesource_setup.sh 
RUN bash nodesource_setup.sh \
    && apt-get install -y nodejs \
    && apt-get clean && rm -rf /var/lib/apt/lists/* \
    && groupmod -g 1000 www-data \
    && usermod -u 1000 -g 1000 www-data \
    && composer global require laravel/installer
WORKDIR /var/www/html
COPY ./backend/composer.json ./backend/composer.lock ./backend/artisan ./
RUN composer install --no-scripts
ENTRYPOINT ["/bin/bash", "-c", "./artisan migrate:fresh; php-fpm"]
EXPOSE 9000