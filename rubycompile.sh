#!/bin/bash
# Ruby 2.4 compile
if [[ -z $(ls | grep ruby-2.4.0.tar.gz) ]]; then
  curl -O https://cache.ruby-lang.org/pub/ruby/2.4/ruby-2.4.0.tar.gz
fi

checksumrun=$(sha256sum ruby-2.4.0.tar.gz | awk '{print $1}')
checksumactual="152fd0bd15a90b4a18213448f485d4b53e9f7662e1508190aa5b702446b29e3d"

if [[ $checksumrun == $checksumactual ]]; then
  tar -xf ruby-2.4.0.tar.gz
  cd ruby-2.4.0
  ./configure
  make
  sudo make install
fi

rm -rf ruby-2.4.0*
