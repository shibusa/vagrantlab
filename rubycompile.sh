#!/bin/bash
# Check if Ruby exists
if ! [ $(ruby -v) == "-bash: ruby: command not found"]; then
  exit
fi

# Ruby Version
rubyversion="2.4.0"
cd /tmp

# Download Ruby
if [[ -z $(ls | grep ruby-$rubyversion.tar.gz) ]]; then
  curl -O https://cache.ruby-lang.org/pub/ruby/${rubyversion%??}/ruby-$rubyversion.tar.gz
fi

checksumrun=$(sha256sum ruby-$rubyversion.tar.gz | awk '{print $1}')
checksumactual="152fd0bd15a90b4a18213448f485d4b53e9f7662e1508190aa5b702446b29e3d"

# Check if hash matches, run if match succeeds
if [[ $checksumrun == $checksumactual ]]; then
  tar -xf ruby-$rubyversion.tar.gz
  cd ruby-$rubyversion
  ./configure
  make
  sudo make install
fi

# Remove files
cd ../
rm ruby-$rubyversion.tar.gz
