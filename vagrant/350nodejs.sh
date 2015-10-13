#!/usr/bin/env bash

set -e
if [ -f ~/nodejs ]; then
    exit
fi

#If you are using Rails, then you must install Node.js. This is because Rails's asset pipeline compiler requires a Javascript runtime. The Node.js version does not matter.
#To install Node.js:
sudo yum install -y epel-release
sudo yum install -y --enablerepo=epel nodejs npm

touch ~/nodejs