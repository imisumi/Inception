FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
        php7.4-fpm \
        php7.4-mysql \
        mariadb-client \
        curl \
        wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


RUN mkdir -p /run/php

COPY www.conf /etc/php/7.4/fpm/pool.d/

RUN mkdir -p /var/www/html

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod u+x wp-cli.phar && \
	./wp-cli.phar core download --allow-root && \
	mv wp-cli.phar /usr/local/bin/wp

WORKDIR /var/www/html

COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["php-fpm7.4", "--nodaemonize"]
