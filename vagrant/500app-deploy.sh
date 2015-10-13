#!/usr/bin/env bash

set -e
if [ -f ~/app-deploy ]; then
    exit
fi


#1 Transferring the app code to the server

#Login to your server, create a user for the app

#Now that you have logged in, you should create an operating system user account for your app. For security reasons, it
# is a good idea to run each app under its own user account, in order to limit the damage that security vulnerabilities
# in the app can do. Passenger will automatically run your app under this user account as part of its user account
# sandboxing feature.
# You should give the user account the same name as your app. But for demonstration purposes, this tutorial names the user
# account myappuser.

#if ! grep vagrant /etc/passwd; then
#    sudo adduser vagrant
    #We also ensure that that user has your SSH key installed:
#fi
#sudo mkdir -p ~vagrant/.ssh
#sudo sh -c "cat $HOME/.ssh/authorized_keys >> ~vagrant/.ssh/authorized_keys"
#sudo chown -R vagrant: ~vagrant/.ssh
#sudo chmod 700 ~vagrant/.ssh
#sudo sh -c "chmod 600 ~vagrant/.ssh/*"


#1.3 Install Git on the server
sudo yum install -y git


#1.4 Pull code
#You need to pick a location in which to permanently store your application's code. A good location is
# /var/www/APP_NAME. Let us create that directory.

sudo mkdir -p /var/www/passenger-ruby-rails-demo
sudo chown vagrant: /var/www/passenger-ruby-rails-demo
#Replace myapp and myappuser with your app's name and your app user account's name.

#Now let us pull the code from Git:
cd /var/www/passenger-ruby-rails-demo
sudo -u vagrant -H git clone https://github.com/phusion/passenger-ruby-rails-demo.git code
#Your app's code now lives on the server at /var/www/passenger-ruby-rails-demo/code.
touch ~/app-deploy