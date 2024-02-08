# WordPress Installation Script for Raspberry Pi
This script automates the installation of WordPress on a Raspberry Pi. It includes the following steps:

* Updates the system
* Installs Apache, MariaDB, and PHP (LAMP Stack)
* Secures the MariaDB installation
* Creates a WordPress database and user
* Downloads and installs WordPress
* Sets permissions
* Cleans up temporary files
* Restarts Apache to apply changes
### Prerequisites
* A Raspberry Pi running Raspbian
* A root user password
### Usage
1. Download to the Raspberry Pi
```sh
sudo apt-get install git
```
2. Download the script to your Raspberry Pi.
```sh
git clone https://github.com/Sharonhazan/pi-wordpress-installer.git
```
3. Make the script executable using the following command:
```sh
chmod +x pi-wordpress-setup.sh
```
4. Run the script using the following command:
```sh
sudo ./pi-wordpress-setup.sh
```
5. Follow the prompts to enter the required information.
6. The script will install WordPress and provide you with the necessary login credentials.

## Todo
1. adding security features (fail2ban)
2. adding DuckDNS automation installtion
   
