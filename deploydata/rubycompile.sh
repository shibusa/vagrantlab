#!/usr/bin/env bash
# Text Output Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

# Ruby Version
rubyversion="2.4.1"
cd /tmp

# Check if Ruby exists
if [[ $(/usr/local/bin/ruby -v | awk '{print $2}') == $rubyversion ]]; then
  echo "Ruby $rubyversion already installed"
  exit 0
fi

# Download Ruby if not copied over by vagrant provision
if [[ -z $(ls | grep ruby-$rubyversion.tar.gz) ]]; then
  echo -e "${GREEN}Downloading Ruby $rubyversion${NC}"
  curl -O https://cache.ruby-lang.org/pub/ruby/${rubyversion%??}/ruby-$rubyversion.tar.gz
fi

# Check if hash matches, run if match succeeds
checksumrun=$(sha256sum ruby-$rubyversion.tar.gz | awk '{print $1}')
checksumactual=$(curl --silent https://www.ruby-lang.org/en/downloads/ | grep -m1 sha256 | awk '{print substr($2, 1, length($2)-5)}')

if [[ $checksumrun == $checksumactual ]]; then
  tar -xf ruby-$rubyversion.tar.gz
  cd ruby-$rubyversion

  ./configure
  make
  make install

  cd ../
  rm -rf ruby-$rubyversion
fi

# Remove files
rm ruby-$rubyversion.tar.gz


if [[ $(/usr/local/bin/ruby -v | awk '{print $2}') == $rubyversion ]]; then
  echo "Ruby $rubyversion installed"
else
  echo "Ruby $rubyversion install failed"
fi
