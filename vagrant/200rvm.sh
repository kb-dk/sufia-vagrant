#!/usr/bin/env bash

set -e
if [ -f ~/rvm ]; then
    exit
fi

#Run the following commands on your production server to install RVM:
sudo gpg2 --keyserver hkp://app.aaiedu.hr --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL https://get.rvm.io | sudo bash -s stable
sudo usermod -a -G rvm `whoami`

#When you are done with all this, relogin to your server to activate RVM. This is important: if you don't relogin, RVM doesn't work.

touch ~/rvm
exit
