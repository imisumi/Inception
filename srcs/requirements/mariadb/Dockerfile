FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y mariadb-server && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


COPY 50-server.cnf /etc/mysql/mariadb.conf.d/
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN mkdir -p /run/mysqld
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 3306

# Set the entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["mysqld"]
