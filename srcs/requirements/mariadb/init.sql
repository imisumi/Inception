-- -- Set the root password (replace 'your_root_password' with a strong password)
-- ALTER USER 'root'@'localhost' IDENTIFIED BY 'pass';

-- -- Create the wordpress database
-- CREATE DATABASE IF NOT EXISTS wordpress_db;

-- -- Create the normal user with a specified password
-- CREATE USER 'wpuser'@'%' IDENTIFIED BY 'password';

-- -- Grant limited privileges to wpuser on the wordpress database
-- GRANT ALL PRIVILEGES ON wordpress_db.* TO 'wpuser'@'%';

-- -- Flush the privileges to ensure that they take effect
-- FLUSH PRIVILEGES;


-- Set the root password (replace 'your_root_password' with a strong password)
ALTER USER 'root'@'localhost' IDENTIFIED BY 'pass';

-- Create the wordpress database
CREATE DATABASE IF NOT EXISTS wordpress_db;

-- Create the normal user with a specified password
CREATE USER IF NOT EXISTS'wpuser'@'%' IDENTIFIED BY 'password';

-- Grant limited privileges to wpuser on the wordpress database
GRANT ALL PRIVILEGES ON wordpress_db.* TO 'wpuser'@'%';

-- Flush the privileges to ensure that they take effect
FLUSH PRIVILEGES;
