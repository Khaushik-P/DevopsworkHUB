FROM php:7.1.23-apache

RUN rm -rf /var/lib/apt/lists/*
RUN echo "deb http://archive.debian.org/debian stretch main" > /etc/apt/sources.list

COPY . /var/www/html

RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install mysqli

EXPOSE 80

CMD ["apache2ctl", "-D", "FOREGROUND"]