#!/usr/bin/env bash
# Standalone config https://docs.chef.io/install_dk.html
# Chef Version
chefdkversion="2.0.26"
checksumactual="89116da26e27fa78337706e8ee0a530b8d7450132ebf33fe0995a78a691d8a66"

# Check if Chef Server exists
if [[ $(chef -v | grep Development | awk '{print $5}') == $chefdkversion ]]; then
  echo "Chef DK $chefdkversion already installed"
  exit 0
fi

# Chef Server prerequisites https://docs.chef.io/install_server_pre.html
if ! [ $(getenforce) == "Permissive" ]; then
  sed -i -e 's|SELINUX=enforcing|SELINUX=permissive|g' /etc/selinux/config
fi

#Download Chef Server
if [[ -z $(ls | grep chefdk-$chefdkversion-1.el7.x86_64.rpm) ]]; then
  curl -O https://packages.chef.io/files/stable/chefdk/$chefdkversion/el/7/chefdk-$chefdkversion-1.el7.x86_64.rpm
fi

checksumrun=$(sha256sum chefdk-$chefdkversion-1.el7.x86_64.rpm | awk '{print $1}')


# Check if hash matches, run if match succeeds
if [[ $checksumrun == $checksumactual ]]; then
  rpm -Uvh chefdk-$chefdkversion-1.el7.x86_64.rpm
fi

# Remove files
rm chefdk-$chefdkversion-1.el7.x86_64.rpm


if [[ $(chef -v | grep Development | awk '{print $5}') == $chefdkversion ]]; then
  echo "Chef DK $chefdkversion installed"
else
  echo "Chef DK $chefdkversion failed to install"
fi

echo 'eval "$(chef shell-init bash)"' >> ~/.bash_profile
echo "system Ruby set"

sudo yum install git -y
echo "git installed"

git config --global user.name "Shirfeng Chang"
