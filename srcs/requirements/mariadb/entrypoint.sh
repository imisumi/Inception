#!/bin/bash

# Only create init.sql if it doesn't already exist
if [ ! -f /etc/mysql/init.sql ]; then
  echo "Creating init.sql file..."

  # Create the init.sql file with the SQL commands
  cat <<EOF > /etc/mysql/init.sql
-- Set the root password
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';

-- Create the WordPress database
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};

-- Create the normal user with a specified password
CREATE USER IF NOT EXISTS '${WORDPRESS_DB_USER}'@'%' IDENTIFIED BY '${WORDPRESS_DB_PASSWORD}';

-- Grant limited privileges to wpuser on the WordPress database
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${WORDPRESS_DB_USER}'@'%';

-- Flush the privileges to ensure that they take effect
FLUSH PRIVILEGES;
EOF

  echo "init.sql created!"
else
  echo "init.sql already exists, skipping creation."
fi

# Start the MySQL server
# exec mysqld

# Execute the main command
exec "$@"
