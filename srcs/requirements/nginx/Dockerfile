FROM debian:bullseye

# Set environment variables for non-interactive installation
ENV DEBIAN_FRONTEND=noninteractive

# Install Nginx
RUN apt-get update && apt-get install -y nginx

# Remove the default configuration file
RUN rm -f /etc/nginx/sites-enabled/default && rm -f /etc/nginx/sites-available/default

COPY default.conf /etc/nginx/conf.d/

CMD ["nginx", "-g", "daemon off;"]