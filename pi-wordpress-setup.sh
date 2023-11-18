#!/bin/bash

# WordPress Installation Script for Raspberry Pi
# Author: Sharon Hazan
# Version: 1.0

# Check if running as root
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root. Try 'sudo bash $0'" 
   exit 1
fi

# Prompt for MariaDB root password
read -p "Enter a MariaDB root password: " mariadbRootPassword
echo

# Prompt for WordPress database details
read -p "Enter a name for the WordPress database: " wpDatabase
read -p "Enter a username for the WordPress database: " wpUser
read -p "Enter a password for the WordPress user: " wpPassword
echo

# Update system
echo "Updating system..."
apt-get update
apt-get upgrade -y

# Install Apache, MariaDB, and PHP (LAMP Stack)
echo "Installing LAMP stack with MariaDB..."
apt-get install apache2 mariadb-server php php-mysql -y

# Secure MariaDB installation
echo "Securing MariaDB..."
mysql_secure_installation <<EOF

$mysqlRootPassword
y
$mysqlRootPassword
$mysqlRootPassword
y
y
y
y
EOF

# Create WordPress Database and User
echo "Creating WordPress database and user..."
mysql -uroot -p$mariadbRootPassword <<QUERY_INPUT
CREATE DATABASE $wpDatabase;
CREATE USER '$wpUser'@'localhost' IDENTIFIED BY '$wpPassword';
GRANT ALL PRIVILEGES ON $wpDatabase.* TO '$wpUser'@'localhost';
FLUSH PRIVILEGES;
EXIT
QUERY_INPUT

# Install WordPress
echo "Installing WordPress..."
wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
cp -R wordpress/* /var/www/html/

# Set permissions
chown -R www-data:www-data /var/www/html/
chmod -R 755 /var/www/html/

# Clean up
rm /var/www/html/index.html
rm latest.tar.gz
rm -rf wordpress

# Restart Apache to apply changes
service apache2 restart
ip=$(hostname -I | awk '{print $1}')
echo "#####################################################"
echo "##        Wordpress and Database info              ##"
echo "##   MariaDB root password:  $mariadbRootPassword  ##" 
echo "##   Name for the WordPress database: $wpDatabase  ##"
echo "##   User for the WordPress database:  $wpUser     ##"
echo "##   password for the WordPress user:  $wpPassword ##"
echo "##   Your raspberrypi address is http://$ip        ##"
echo "#####################################################"

echo "WordPress installation completed. Access and configure it through your web browser."
