#!/bin/bash

# Uninstall Script for WordPress Installation on Raspberry Pi
# Author: Sharon Hazan
# Version: 1.0

# Define color codes
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Check if running as root
if [ "$(id -u)" != "0" ]; then
   echo -e "${GREEN}This script must be run as root. Try 'sudo bash $0'${NC}" 
   exit 1
fi

# Uninstall Apache, MariaDB, PHP, and related packages
echo -e "${GREEN}Uninstalling LAMP stack components...${NC}"
apt-get purge apache2 mariadb-server php php-mysql -y

# Remove configuration files
echo -e "${GREEN}Removing configuration files...${NC}"
apt-get purge apache2 mariadb-server php php-mysql -y
apt-get autoremove -y
apt-get autoclean

echo -e "${GREEN}WordPress and LAMP stack components have been uninstalled successfully.${NC}"

