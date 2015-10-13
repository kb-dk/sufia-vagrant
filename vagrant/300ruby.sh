#!/usr/bin/env bash

set -e
if [ -f ~/ruby ]; then
    exit
fi

sudo yum install -y epel-release

sudo yum -y install ruby
sudo yum -y install gcc g++ make automake autoconf curl-devel openssl-devel zlib-devel httpd-devel apr-devel apr-util-devel sqlite-devel
sudo yum -y install ruby-rdoc ruby-devel
sudo yum -y install rubygems
sudo yum -y install rubygem-bundler
sudo yum -y install libxslt-devel

touch ~/ruby