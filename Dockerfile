# Start with a base image
FROM wordpress

# Install dependencies and monitoring tools
RUN apt-get update && apt-get install -y \
    apache2 \
    libapache2-mod-php \
    php \
    php-mysql \
    curl \
    vim \
    && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Copy the application code
COPY app /var/www/html

# Configure the Apache web server
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html \
    && a2enmod rewrite \
    && a2enmod headers \
    && a2enmod ssl

# Copy Apache configuration
COPY apache2.conf /etc/apache2/apache2.conf

# Create directory for SSL certificates
RUN mkdir -p /etc/apache2/ssl

# Set environment variables
ENV APACHE_RUN_USER=www-data \
    APACHE_RUN_GROUP=www-data \
    APACHE_LOG_DIR=/var/log/apache2 \
    APACHE_LOCK_DIR=/var/lock/apache2 \
    APACHE_PID_FILE=/var/run/apache2.pid

# Create necessary directories
RUN mkdir -p ${APACHE_LOG_DIR} ${APACHE_LOCK_DIR} \
    && chown -R www-data:www-data ${APACHE_LOG_DIR} ${APACHE_LOCK_DIR}

# Expose ports
EXPOSE 80 443

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost/ || exit 1

# Start the Apache web server
CMD ["apache2-foreground"]
