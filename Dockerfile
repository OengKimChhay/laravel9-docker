FROM php:8.2-fpm


# ENV USER=oengkimchhay
# ENV GROUP=www

# Setup working directory
WORKDIR /var/www/html

COPY . .

# Install system dependencies
RUN apt-get update && apt-get install -y \
    openssl \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip

# php extension
RUN docker-php-ext-install \
    pdo \
    pdo_mysql \
    # for postgresql
    # pdo_pgsql \
    # pgsql \
    mbstring \
    exif \
    pcntl \
    bcmath \
    xml \
    gd

# Clear cache
RUN apt-get clean && rm -rf /var/cache/apt/*

# installing Composer from the official website
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
# or
# copying composer from an existing Composer image
# COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer


# Create User and Group
# RUN groupadd -g 1000 ${GROUP} && useradd -u 1000 -ms /bin/bash -g ${GROUP} ${USER}
# Grant Permissions
# RUN chown -R ${USER} /var/www/html
# Select User
# USER ${USER}
# Copy permission to selected user
# COPY --chown=${USER}:${GROUP} . .

# Create system user to run Composer and Artisan Commands
# RUN useradd -G www-data,root -u 1000 -d /home/${USER} ${USER}
# RUN mkdir -p /home/${USER}/.composer && \
#     chown -R ${USER}:${USER} /home/${USER}


# USER ${USER}

# Set the script as the entrypoint
# ENTRYPOINT ["entrypoint.sh"]

# Expose port 9000 for PHP-FPM
EXPOSE 9000
CMD ["php-fpm"]
