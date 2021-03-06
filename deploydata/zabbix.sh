#!/usr/bin/env bash
# Install from distribution https://www.zabbix.com/documentation/3.2/manual/installation/getting_zabbix
# Zabbix Version
zabbixversion="3.2.5"

if [[ $(zabbix_server -V | grep zabbix_server | awk '{print $3}') == $zabbixversion ]]; then
  echo "Zabbix already installed"
  exit 0
fi

sudo rpm -ivh http://repo.zabbix.com/zabbix/3.2/rhel/7/x86_64/zabbix-release-3.2-1.el7.noarch.rpm
sudo yum install zabbix-server-mysql zabbix-web-mysql mariadb-server mariadb net-snmp net-snmp-utils -y
systemctl enable mariadb
sudo systemctl start mariadb

# mysql -u root -p
# create database zabbix character set utf8 collate utf8_bin;
# grant all privileges on zabbix.* to zabbix@localhost identified by '$password';
# quit;
# zcat /usr/share/doc/zabbix-server-mysql-$zabbixversion/create.sql.gz | mysql -u zabbix -p zabbix

sudo setsebool -P httpd_can_connect_zabbix on
sudo sed -i -e 's|SELINUX=enforcing|SELINUX=permissive|g' /etc/selinux/config
sudo setenforce Permissive

sudo sed -i -e 's|# DBPassword=|# DBPassword=\nDBPassword='$password'|g' /etc/zabbix/zabbix_server.conf
sudo systemctl enable zabbix-server
sudo systemctl start zabbix-server

sudo sed -i -e 's|# php_value date.timezone Europe/Riga|php_value date.timezone America/Los_Angeles|g' /etc/httpd/conf.d/zabbix.conf
sudo sed -i -e 's|DocumentRoot "/var/www/html"|DocumentRoot "/usr/share/zabbix"|g' /etc/httpd/conf.d/zabbix.conf
sudo systemctl enable httpd
sudo systemctl start httpd

# mysql_secure_installation
