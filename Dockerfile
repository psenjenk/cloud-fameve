# Start with a base image
FROM wordpress

# Install dependencies
RUN apt-get update && apt-get install -y \
    apache2 \
    libapache2-mod-php \
    php \
    mysql-server \
    php-mysql

# Copy the application code
COPY app /var/www/html

# Configure the Apache web server
RUN chown -R www-data:www-data /var/www/html
RUN a2enmod rewrite
COPY apache2.conf /etc/apache2/apache2.conf

# Start the Apache web server when the container is run
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
