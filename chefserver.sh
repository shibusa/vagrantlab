#!/usr/bin/env bash
# Standalone config https://docs.chef.io/install_server.html#standalone
# Chef Version
chefserverversion="12.15.8"
checksumactual="57f9a5a165c4e9afa80babad39fb23f54e7662c6efc9a17f3d9e5cbae5ac3339"

# Check if Chef Server exists
if [[ $(head -n1 /opt/opscode/version-manifest.txt | awk '{print $2}') == $chefserverversion ]]; then
  echo "Chef Server $chefserverversion already installed"
  exit 0
fi

# Chef Server prerequisites https://docs.chef.io/install_server_pre.html
if ! [ $(getenforce) == "Permissive" ]; then
  sed -i -e 's|SELINUX=enforcing|SELINUX=permissive|g' /etc/selinux/config
fi

#Download Chef Server
if [[ -z $(ls | grep chef-server-core-$chefserverversion-1.el7.x86_64.rpm) ]]; then
  curl -O https://packages.chef.io/files/stable/chef-server/$chefserverversion/el/7/chef-server-core-$chefserverversion-1.el7.x86_64.rpm
fi

checksumrun=$(sha256sum chef-server-core-$chefserverversion-1.el7.x86_64.rpm | awk '{print $1}')

# Check if hash matches, run if match succeeds
if [[ $checksumrun == $checksumactual ]]; then
  rpm -Uvh chef-server-core-$chefserverversion-1.el7.x86_64.rpm
  chef-server-ctl reconfigure
fi

# Remove files
rm chef-server-core-$chefserverversion-1.el7.x86_64.rpm

if [[ $(head -n1 /opt/opscode/version-manifest.txt | awk '{print $2}') == $chefserverversion ]]; then
  echo "Chef Server $chefserverversion installed"
else
  echo "Chef Server $chefserverversion failed to install"
fi
