#!/usr/bin/env bash

packagename="jenkins"
packageversion="2.60.2-1.1"
package="https://pkg.jenkins.io/redhat-stable/jenkins.repo"
key="https://pkg.jenkins.io/redhat-stable/jenkins.io.key"

# need to figure out a away to automate java jdk 8
# curl requests need to accept license
# currently file is saved in deploydata

sudo yum localinstall /tmp/jre-8u144-linux-x64.rpm -y

if [ ! -f /etc/yum.repos.d/$packagename.repo ]; then
  sudo curl -o /etc/yum.repos.d/$packagename.repo $package
fi

if [[ $(rpm -qi $packagename-$packageversion) != "package $packagename is not installed" ]]; then
  sudo rpm --import $key
fi

# needs revision. change code so it checks if packagename is part of string
if [ ! $(rpm -qa | grep $packagename-$packageversion) ]; then
  sudo yum install $packagename-$packageversion -y
fi

sudo systemctl enable jenkins
sudo systemctl start jenkins
