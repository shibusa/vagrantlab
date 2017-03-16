#/usr/bin/env bash
#Virtualbox Version
vboxversion="5.1.18"

# Check if Guest Additions exists
if [[ $(modinfo vboxguest | grep -m 1  version | awk '{print $2}') == $vboxversion ]]; then
  echo "Guest Additions already installed and up to date"
  exit 0
fi

# Update everything
yum check-update -y
yum install make gcc kernel-devel-`uname -r` -y

#Download Guest Additions and Hashfile
if [[ -z $(ls | grep VBoxGuestAdditions_$vboxversion.iso) ]]; then
  curl -O http://download.virtualbox.org/virtualbox/$vboxversion/VBoxGuestAdditions_$vboxversion.iso
fi

if [[ -z $(ls | grep SHA256SUMS) ]]; then
  curl -O http://download.virtualbox.org/virtualbox/$vboxversion/SHA256SUMS
fi

checksumrun=$(sha256sum VBoxGuestAdditions_$vboxversion.iso | awk '{print $1}')
checksumactual=$(less SHA256SUMS | grep VBoxGuestAdditions | awk '{print $1}')

# Check if hash matches, run if match succeeds
if [[ $checksumrun == $checksumactual ]]; then
  mount VBoxGuestAdditions_$vboxversion.iso /mnt
  sh /mnt/VBoxLinuxAdditions.run
  umount /mnt
fi

# Remove files
rm VBoxGuestAdditions_$vboxversion.iso SHA256SUMS
