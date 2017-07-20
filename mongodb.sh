#!/usr/bin/env bash
# MongoDB Centos7 install https://docs.mongodb.com/manual/tutorial/install-mongodb-on-red-hat/
mongodbversion="3.4"

if [ -f /etc/yum.repos.d/mongodb-org-$mongodbversion.repo ]; then
  echo "MondoDB repository created"
  exit 0
fi

echo -e '[mongodb-org-'$mongodbversion']\nname=MongoDB Repository\nbaseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/'$mongodbversion'/x86_64/\ngpgcheck=1\nenabled=1\ngpgkey=https://www.mongodb.org/static/pgp/server-'$mongodbversion'.asc' | tee -a /etc/yum.repos.d/mongodb-org-$mongodbversion.repo

sudo yum install -y mongodb-org
sed -i -e 's|SELINUX=enforcing|SELINUX=disabled|g' /etc/selinux/config

sudo systemctl enable mongod
sudo systemctl start mongod
