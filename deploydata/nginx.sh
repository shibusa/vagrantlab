#!/usr/bin/env bash
# Text Output Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

#Virtualbox Version
nginxversion="1.12.1"

if [ -f /etc/yum.repos.d/nginx.repo ]; then
  echo "nginx repository already created"
  exit 0
fi

sudo rpm --import https://nginx.org/keys/nginx_signing.key
echo -e "[nginx]\nname=nginx repo\nbaseurl=http://nginx.org/packages/centos/7/x86_64/\ngpgcheck=1\nenabled=1" | sudo tee -a /etc/yum.repos.d/nginx.repo

sudo yum install nginx -y
