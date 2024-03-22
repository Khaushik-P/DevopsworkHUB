# Use the official PHP image as base
FROM php:7.4-apache

# Install necessary extensions and tools
RUN apt-get update && apt-get install -y \
    libicu-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd intl mysqli pdo_mysql zip

# Download and install phpMyAdmin
ENV PHPMYADMIN_VERSION=5.1.1
RUN curl -L -o phpmyadmin.zip https://files.phpmyadmin.net/phpMyAdmin/${PHPMYADMIN_VERSION}/phpMyAdmin-${PHPMYADMIN_VERSION}-all-languages.zip \
    && unzip phpmyadmin.zip \
    && rm phpmyadmin.zip \
    && mv phpMyAdmin-* /phpmyadmin

# Copy website files
COPY leave_staff /var/www/html/leave_staff

# Apache configuration
COPY config/phpmyadmin.conf /etc/apache2/conf-available/phpmyadmin.conf
COPY config/leave_staff.conf /etc/apache2/sites-available/leave_staff.conf
RUN a2ensite leave_staff.conf \
    && ln -s /etc/apache2/conf-available/phpmyadmin.conf /etc/apache2/conf-enabled/phpmyadmin.conf \
    && echo "Include /etc/phpmyadmin/apache.conf" >> /etc/apache2/apache2.conf

# Expose ports
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]
