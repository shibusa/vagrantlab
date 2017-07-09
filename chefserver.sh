#/usr/bin/env bash
# Standalone config https://docs.chef.io/install_server.html#standalone
# Chef Version
chefversion="12.15.8"

# Check if Chef Server exists
if [[ $(head -n1 /opt/opscode/version-manifest.txt | awk '{print $2}') == $chefversion ]]; then
  echo "Chef Server already installed"
  exit 0
fi

# Chef Server prerequisites https://docs.chef.io/install_server_pre.html
if ! [ $(getenforce) == "Permissive" ]; then
  setenforce Permissive
fi

#Download Chef Server
if [[ -z $(ls | grep chef-server-core-$chefversion-1.el7.x86_64.rpm) ]]; then
  curl -O https://packages.chef.io/files/stable/chef-server/$chefversion/el/7/chef-server-core-$chefversion-1.el7.x86_64.rpm
fi

checksumrun=$(sha256sum chef-server-core-$chefversion-1.el7.x86_64.rpm | awk '{print $1}')
checksumactual="57f9a5a165c4e9afa80babad39fb23f54e7662c6efc9a17f3d9e5cbae5ac3339"

# Check if hash matches, run if match succeeds
if [[ $checksumrun == $checksumactual ]]; then
  rpm -Uvh chef-server-core-$chefversion-1.el7.x86_64.rpm
  chef-server-ctl reconfigure
fi

# Remove files
rm chef-server-core-$chefversion-1.el7.x86_64.rpm
