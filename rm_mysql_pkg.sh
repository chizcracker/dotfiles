#!/bin/bash

# OSX only, 
# MySQL 5.1 pkg uninstall script
# manually remove lines related to mysql in /etc/hostconfig 

sudo
sudo rm /usr/local/mysql
sudo rm -rf /usr/local/mysql*
sudo rm -rf /Library/StartupItems/MySQLCOM
sudo rm -rf /Library/PreferencePanes/My*
sudo rm -rf /var/db/receipts/com.my
sudo vi /etc/hostconfig
