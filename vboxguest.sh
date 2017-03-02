#!/bin/bash
#Install Guest Additions
vboxversion=5.1.14
yum install make wget gcc kernel-devel-`uname -r` -y
wget http://download.virtualbox.org/virtualbox/$vboxversion/VBoxGuestAdditions_$vboxversion.iso
mount VBoxGuestAdditions_$vboxversion.iso /mnt
sh /mnt/VBoxLinuxAdditions.run
umount /mnt
rm VBoxGuestAdditions_$vboxversion.iso
