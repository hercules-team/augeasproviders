#!/bin/bash
set -xe

# Clone submodules in tree
git submodule update --init

if [ -z $AUGEAS ]; then
  # Use latest version of lenses
  cd augeas && git pull origin master
  PKG_VERSION=""
else
  if [ -z $LENSES ]; then
    # Use matching version of lenses
    cd augeas && git checkout release-${AUGEAS}
  else
    cd augeas && git checkout $LENSES
  fi

  PKG_VERSION="=${AUGEAS}*"
  # Add PPA
  sudo add-apt-repository -y ppa:raphink/augeas-1.0.0
  sudo add-apt-repository -y ppa:raphink/augeas-1.1.0
  sudo add-apt-repository -y ppa:raphink/augeas-1.2.0
  sudo add-apt-repository -y ppa:raphink/augeas-1.3.0
fi
sudo add-apt-repository -y ppa:raphink/augeas
sudo apt-get update
sudo apt-get install augeas-tools${PKG_VERSION} \
                     augeas-lenses${PKG_VERSION} \
                     libaugeas0${PKG_VERSION} \
                     libaugeas-dev${PKG_VERSION} \
                     libxml2-dev

# Install gems
gem install bundler
bundle update puppet

# Reporting only
bundle show
puppet --version
augtool --version
