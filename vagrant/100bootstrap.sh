#!/usr/bin/env bash

set -e
if [ -f ~/bootstrap ]; then
    exit
fi


#https://www.phusionpassenger.com/library/walkthroughs/deploy/ruby/ownserver/apache/oss/install_language_runtime.html
# Ensure that curl and gpg are installed, as well as a compiler toolchain.
# Curl and gpg are needed for further installation steps, while the compiler toolchain is needed for installing common Ruby gems.
sudo yum install -y curl gpg gcc gcc-c++ make

touch ~/bootstrap