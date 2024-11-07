#!/bin/bash

# echo "Starting MariaDB setup..."

# # Start the MariaDB server in the background for setup
# mysqld --skip-networking &
# pid="$!"

# echo "MariaDB is starting..."

# # Wait for MariaDB to be ready
# until mysqladmin ping >/dev/null 2>&1; do
#   echo "Waiting for MariaDB to start..."
#   sleep 2
# done

# echo "MariaDB is ready!"

# # Run the SQL commands to initialize the database and users
# cat <<EOF | mysql -u root
# -- Set the root password (replace 'your_root_password' with a strong password)
# ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';

# -- Create the WordPress database
# CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};

# -- Create the normal user with a specified password
# CREATE USER IF NOT EXISTS '${WORDPRESS_DB_USER}'@'%' IDENTIFIED BY '${WORDPRESS_DB_PASSWORD}';

# -- Grant limited privileges to wpuser on the WordPress database
# GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${WORDPRESS_DB_USER}'@'%';

# -- Flush the privileges to ensure that they take effect
# FLUSH PRIVILEGES;
# EOF

# # Stop the temporary MariaDB process
# kill "$pid"
# wait "$pid"

# # Start MariaDB in the foreground (container's main process)
# exec mysqld



# cat <<EOF > /etc/mysql/init.sql
# -- Set the root password
# ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';

# -- Create the WordPress database
# CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};

# -- Create the normal user with a specified password
# CREATE USER IF NOT EXISTS '${WORDPRESS_DB_USER}'@'%' IDENTIFIED BY '${WORDPRESS_DB_PASSWORD}';

# -- Grant limited privileges to wpuser on the WordPress database
# GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${WORDPRESS_DB_USER}'@'%';

# -- Flush the privileges to ensure that they take effect
# FLUSH PRIVILEGES;
# EOF

# exec mysqld

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
exec mysqld
