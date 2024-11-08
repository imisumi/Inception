FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive

# Install required packages and generate SSL certs
RUN apt-get update && \
    apt-get install -y nginx openssl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /etc/ssl/private /etc/ssl/certs && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/selfsigned.key -out /etc/ssl/certs/selfsigned.crt \
    -subj "/C=NL/ST=North Holland/L=Amsterdam/O=imisumi Inc./OU=IT Department/CN=imisumi.42.fr" && \
    rm -f /etc/nginx/sites-enabled/default && rm -f /etc/nginx/sites-available/default && \
    rm -f /etc/nginx/conf.d/default.conf

# Copy custom Nginx config
COPY default.conf /etc/nginx/conf.d/

CMD ["nginx", "-g", "daemon off;"]
