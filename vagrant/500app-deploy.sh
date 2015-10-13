#!/usr/bin/env bash

set -e
if [ -f ~/app-deploy ]; then
    exit
fi


#1.4 Pull code
#You need to pick a location in which to permanently store your application's code. A good location is
# /var/www/APP_NAME. Let us create that directory.

sudo mkdir -p /var/www/sufia
sudo chown vagrant: /var/www/sufia

ln -s /app /var/www/sufia/code


touch ~/app-deploy