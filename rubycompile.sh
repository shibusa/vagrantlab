#!/usr/bin/env bash

# Ruby Version
rubyversion="2.4.1"
checksumactual="a330e10d5cb5e53b3a0078326c5731888bb55e32c4abfeb27d9e7f8e5d000250"

# Check if Ruby exists
if [[ $(/usr/local/bin/ruby -v | awk '{print match($2, rubyversion)}') > 0 ]]; then
  echo "Ruby $rubyversion already installed"
  exit 0
fi

cd /tmp

# Download Ruby
if [[ -z $(ls | grep ruby-$rubyversion.tar.gz) ]]; then
  curl -O https://cache.ruby-lang.org/pub/ruby/${rubyversion%??}/ruby-$rubyversion.tar.gz
fi

# Check if hash matches, run if match succeeds
checksumrun=$(sha256sum ruby-$rubyversion.tar.gz | awk '{print $1}')
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


if [[ $(/usr/local/bin/ruby -v | awk '{print match($2, rubyversion)}') > 0 ]]; then
  echo "Ruby $rubyversion installed"
else
  echo "Ruby $rubyversion install failed"
fi
