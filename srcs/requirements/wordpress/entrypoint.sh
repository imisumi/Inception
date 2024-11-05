#!/bin/bash

# Wait for MariaDB to be ready
# until mysqladmin --host=mariadb --user=wpuser --password=password --silent ping; do
#     >&2 echo "mariadb is sleeping"
#     sleep 10
# done

# WordPress Configuration
# echo "wordpress env variables"
# echo "WORDPRESS_DB_HOST: $WORDPRESS_DB_HOST"
# echo "WORDPRESS_DB_USER: $WORDPRESS_DB_USER"
# echo "WORDPRESS_DB_PASSWORD: $WORDPRESS_DB_PASSWORD"
# echo "WORDPRESS_DB_NAME: $WORDPRESS_DB_NAME"
# echo "WORDPRESS_SITE_URL: $WORDPRESS_SITE_URL"
# echo "WORDPRESS_SITE_TITLE: $WORDPRESS_SITE_TITLE"
# echo "WORDPRESS_ADMIN_USER: $WORDPRESS_ADMIN_USER"
# echo "WORDPRESS_ADMIN_PASSWORD: $WORDPRESS_ADMIN_PASSWORD"
# echo "WORDPRESS_ADMIN_EMAIL: $WORDPRESS_ADMIN_EMAIL"


# # Download WordPress if not already downloaded
# if [ ! -f wp-config.php ]; then
#     wp core download --allow-root
#     wp config create --dbname=wordpress --dbuser=wpuser --dbpass=password --dbhost=mariadb --allow-root
#     wp core install --url=localhost --title=inception --admin_user=admin --admin_password=admin --allow-root
# fi

# WordPress Configuration
# echo "wordpress env variables"
# echo "WORDPRESS_DB_HOST: $WORDPRESS_DB_HOST"
# echo "WORDPRESS_DB_USER: $WORDPRESS_DB_USER"
# echo "WORDPRESS_DB_PASSWORD: $WORDPRESS_DB_PASSWORD"
# echo "WORDPRESS_DB_NAME: $WORDPRESS_DB_NAME"
# echo "WORDPRESS_SITE_URL: $WORDPRESS_SITE_URL"
# echo "WORDPRESS_SITE_TITLE: $WORDPRESS_SITE_TITLE"
# echo "WORDPRESS_ADMIN_USER: $WORDPRESS_ADMIN_USER"
# echo "WORDPRESS_ADMIN_PASSWORD: $WORDPRESS_ADMIN_PASSWORD"
# echo "WORDPRESS_ADMIN_EMAIL: $WORDPRESS_ADMIN_EMAIL"

until mysqladmin --host=$WORDPRESS_DB_HOST --user=$WORDPRESS_DB_USER --password=$WORDPRESS_DB_PASSWORD --silent ping; do
	>&2 echo "mariadb is sleeping"
	sleep 10
done

echo "mariadb is ready"

# Download WordPress if not already downloaded
if [ ! -f wp-config.php ]; then
    wp core download --allow-root
    
    # Use environment variables for database configuration
    wp config create --dbname="$WORDPRESS_DB_NAME" --dbuser="$WORDPRESS_DB_USER" --dbpass="$WORDPRESS_DB_PASSWORD" --dbhost="$WORDPRESS_DB_HOST" --allow-root

    # Use environment variables for WordPress site setup
    wp core install --url="$WORDPRESS_SITE_URL" --title="$WORDPRESS_SITE_TITLE" --admin_user="$WORDPRESS_ADMIN_USER" --admin_password="$WORDPRESS_ADMIN_PASSWORD" --admin_email="$WORDPRESS_ADMIN_EMAIL" --allow-root
    echo "wordpress installed"
fi

# Execute the main command
exec "$@"
