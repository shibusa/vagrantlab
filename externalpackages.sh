#!/usr/bin/env bash
# Run this to download additional software
# Add line to vagrant file *nginx.vm.provision "file", source: "VBoxGuestAdditions_#{vboxversion}.iso", destination: "/tmp/VBoxGuestAdditions_#{vboxversion}.iso"


# Text Output Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

cd deploydata
#Download Guest Additions
vboxversion="5.1.24"
if [[ -z $(ls | grep VBoxGuestAdditions_$vboxversion.iso) ]]; then
  echo -e "${GREEN}Downloading VBoxGuestAdditions_$vboxversion.iso${NC}"
  curl -O http://download.virtualbox.org/virtualbox/$vboxversion/VBoxGuestAdditions_$vboxversion.iso
fi

#Download Git
gitversion="2.13.3"
if [[ -z $(ls | grep git-$gitversion.tar.gz) ]]; then
  echo -e "${GREEN}Downloading git-$gitversion.tar.gz${NC}"
  curl -O https://www.kernel.org/pub/software/scm/git/git-$gitversion.tar.gz
fi
