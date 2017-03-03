#/usr/bin/env bash
# Upgrade everything
yum upgrade -y

#Install epel-release (Extra Packages for Enterprise Linux)
yum install epel-release -y

#Install compiler tools
yum install make gcc kernel-devel-`uname -r` -y

#Install NTP (Remember to change selected peers)
yum install ntp -y
systemctl enable ntpd
systemctl start ntpd

#Set Timezone
timedatectl set-timezone America/Los_Angeles

#Disable IPv6
sysctl -w net.ipv6.conf.all.disable_ipv6=1
sysctl -w net.ipv6.conf.default.disable_ipv6=1
