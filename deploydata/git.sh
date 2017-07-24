#!/usr/bin/env bash
# Text Output Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

# Git Version
gitversion="2.13.3"
cd /tmp

# # Check if Git exists
if [[ $(git --version | awk '{print $3}') == $gitversion ]]; then
  echo -e "${GREEN}Git $gitversion already installed${NC}"
  exit 0
fi

# Download Git if not copied over by vagrant provision
if [[ -z $(ls | grep git-$gitversion.tar.gz) ]]; then
  curl -O https://www.kernel.org/pub/software/scm/git/git-$gitversion.tar.gz
fi

checksumrun=$(openssl dgst -sha256 git-$gitversion.tar.gz | awk '{print $2}')
checksumactual=$(curl --silent https://www.kernel.org/pub/software/scm/git/sha256sums.asc | grep git-$gitversion.tar.gz | awk '{print $1}')

# Check if hash matches, run if match succeeds
if [[ $checksumrun == $checksumactual ]]; then
  yum check-update -y
  yum install dh-autoreconf curl-devel expat-devel gettext-devel asciidoc xmlto docbook2X zlib-devel perl-devel -y
  ln -s /usr/bin/db2x_docbook2texi /usr/bin/docbook2x-texi

  tar -xf git-$gitversion.tar.gz
  cd git-$gitversion
  make configure
  ./configure --prefix=/usr
  make all doc info
  make install install-doc install-html install-info
fi

# Remove files
cd ../
rm -rf git-$gitversion
rm git-$gitversion.tar.gz

if [[ $(git --version | awk '{print $3}') == $gitversion ]]; then
  echo -e "${GREEN}Git $gitversion installed${NC}"
else
  echo -e "${GREEN}Git $gitversion install failed${NC}"
fi
