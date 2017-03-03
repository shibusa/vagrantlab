#!/bin/bash
#Install Guest Additions
vboxversion=5.1.14
if [[ -z $(ls | grep VBoxGuestAdditions_$vboxversion.iso) ]]; then
  curl -O http://download.virtualbox.org/virtualbox/$vboxversion/VBoxGuestAdditions_$vboxversion.iso
fi

checksumrun=$(sha256sum VBoxGuestAdditions_$vboxversion.iso | awk '{print $1}')
checksumactual=$(less SHA256SUMS | grep VBoxGuestAdditions | awk '{print $1}')

if [[ $checksumrun == $checksumactual ]]; then
  mount VBoxGuestAdditions_$vboxversion.iso /mnt
  sh /mnt/VBoxLinuxAdditions.run
  umount /mnt
fi

rm VBoxGuestAdditions_$vboxversion.iso SHA256SUMS
