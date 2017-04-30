#/usr/bin/env bash
# Zabbix Version
zabbixversion="3.2.5"

if [[ $(zabbix_server -V | grep zabbix_server | awk '{print $3}') == $zabbixversion ]]; then
  echo "Zabbix already installed"
  exit 0
fi

rpm -ivh http://repo.zabbix.com/zabbix/3.2/rhel/7/x86_64/zabbix-release-3.2-1.el7.noarch.rpm
yum install zabbix-server-mysql zabbix-web-mysql mariadb-server mariadb -y
systemctl enable mariadb
systemctl start mariadb

# mysql_secure_installation
# mysql -u root -p
# create database zabbix character set utf8 collate utf8_bin;
# grant all privileges on zabbix.* to zabbix@localhost identified by '<password>';
# quit;
# zcat /usr/share/doc/zabbix-server-mysql-$zabbixversion/create.sql.gz | mysql -u zabbix -p zabbix
