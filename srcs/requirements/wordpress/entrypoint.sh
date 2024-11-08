#!/bin/bash

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
