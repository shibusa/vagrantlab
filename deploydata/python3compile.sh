#!/usr/bin/env bash

# Python3 Version
pythonversion="3.6.2"

# Check if python3 exists
if [[ $(/usr/local/bin/python3 -V | awk '{print $2}') == $pythonversion ]]; then
  echo "Python $pythonversion already installed"
  exit 0
fi

cd /tmp

# Download Python
if [[ -z $(ls | grep Python-$pythonversion.tgz) ]]; then
  curl -O https://www.python.org/ftp/python/$pythonversion/Python-$pythonversion.tgz
fi

# Check if hash matches, run if match succeeds
checksumrun=$(md5sum Python-$pythonversion.tgz | awk '{print $1}')
checksumactual="e1a36bfffdd1d3a780b1825daf16e56c"

if  [[ $checksumrun == $checksumactual ]]; then
  yum-builddep python -y

  tar xf Python-$pythonversion.tgz
  cd Python-$pythonversion

  ./configure
  make
  make install

  cd ../
  rm -rf Python-$pythonversion
fi

# Remove files

rm Python-$pythonversion.tgz

if [[ $(/usr/local/bin/python3 -V | awk '{print $2}') == $pythonversion ]]; then
  echo "Python $pythonversion installed"
else
  echo "Python $pythonversion install failed"
fi
