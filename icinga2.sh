#/usr/bin/env bash
# https://docs.icinga.com/icinga2/latest/doc/module/icinga2/chapter/getting-started#getting-started

# Permissive selinux
sed -i -e 's|SELINUX=enforcing|SELINUX=permissive|g' /etc/selinux/config
sed -i -e 's|SELINUX=enforcing|SELINUX=permissive|g' /etc/sysconfig/selinux
sed -i -e 's|;date.timezone =|date.timezone = "America/Los_Angeles"|g' /etc/php.ini
setenforce Permissive

# icinga2 basics
yum install https://packages.icinga.com/epel/7/release/noarch/icinga-rpm-release-7-1.el7.centos.noarch.rpm -y
yum install icinga2 nagios-plugins-all php-ZendFramework-Db-Adapter-Pdo-Mysql icingaweb2 icingacli -y
systemctl enable icinga2
systemctl start icinga2

# apache install
yum install httpd -y
systemctl enable httpd
systemctl start httpd

# icinga2 web
yum install mariadb-server mariadb icinga2-ido-mysql -y
systemctl enable mariadb
systemctl start mariadb

# # mysql secure setup
# mysql_secure_installation
# mysql -u root -p
# CREATE DATABASE icinga;
# GRANT SELECT, INSERT, UPDATE, DELETE, DROP, CREATE VIEW, INDEX, EXECUTE ON icinga.* TO 'icinga'@'localhost' IDENTIFIED BY 'icinga';
# quit
# mysql -u root -p icinga < /usr/share/icinga2-ido-mysql/schema/mysql.sql

icinga2 feature enable ido-mysql
icinga2 feature enable command
icinga2 api setup
systemctl restart icinga2
usermod -a -G icingacmd apache
icingacli setup token create

echo "Save token, setup mysql tables, and issue reboot."
