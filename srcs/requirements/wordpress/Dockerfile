FROM debian:bullseye

# Set environment variables for non-interactive installation
ENV DEBIAN_FRONTEND=noninteractive

# Install Nginx
RUN apt-get update && apt-get install -y \
	php7.4-fpm \
	php7.4-mysql \
	mariadb-client \
	curl \
	wget

RUN mkdir -p /run/php

COPY www.conf /etc/php/7.4/fpm/pool.d/

# Create necessary directories
RUN mkdir -p /var/www/html


# Install WP-CLI
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod u+x wp-cli.phar && \
	./wp-cli.phar core download --allow-root && \
	mv wp-cli.phar /usr/local/bin/wp

# Set the working directory
WORKDIR /var/www/html

# Wait for MariaDB to be ready
# RUN until mysql -h mariadb -u wpuser -password -e "SHOW DATABASES;"; do sleep 5; done
# Wait for MariaDB to be ready
# RUN bash -c "until mysqladmin --host=mariadb --user=wpuser --password=password --silent ping; do \
#     >&2 echo 'mariadb is sleeping'; \
#     sleep 5; \
# done"


# Download WordPress using WP-CLI (skip this if you want to do it in an entrypoint script)
# RUN wp core download --allow-root
# RUN wp config create --dbname=wordpress --dbuser=wpuser --dbpass=password --dbhost=mariadb --allow-root
# RUN wp core install --url=localhost --title=inception --admin_user=admin --admin_password=admin --allow-root

# ./wp-cli.phar config create --dbname=wordpress --dbuser=wpuser --dbpass=password --dbhost=mariadb --allow-root && \
# ./wp-cli.phar core install --url=localhost --title=inception --admin_user=admin --admin_password=admin --admin_email=admin@admin.com --allow-root



EXPOSE 9000

# CMD ["php-fpm7.4", "--nodaemonize"]
# Set the entrypoint to the script

COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["php-fpm7.4", "--nodaemonize"]