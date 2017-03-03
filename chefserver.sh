#!/bin/bash
# Standalone config https://docs.chef.io/install_server.html#standalone
if [[ -z $(ls | grep chef-server-core-12.13.0-1.el7.x86_64.rpm) ]]; then
  curl -O https://packages.chef.io/files/stable/chef-server/12.13.0/el/7/chef-server-core-12.13.0-1.el7.x86_64.rpm
fi

checksumrun=$(sha256sum chef-server-core-12.13.0-1.el7.x86_64.rpm | awk '{print $1}')
checksumactual="57f9a5a165c4e9afa80babad39fb23f54e7662c6efc9a17f3d9e5cbae5ac3339"

if [[ $checksumrun == $checksumactual ]]; then
  rpm -Uvh chef-server-core-12.13.0-1.el7.x86_64.rpm
  chef-server-ctl reconfigure
fi

rm chef-server-core-12.13.0-1.el7.x86_64.rpm
