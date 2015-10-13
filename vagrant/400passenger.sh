#!/usr/bin/env bash



if [ -f ~/passenger ]; then
    exit
fi
# https://www.phusionpassenger.com/library/walkthroughs/deploy/ruby/ownserver/apache/oss/el7/install_passenger.html

#Step 1: install Passenger packages
# These commands will install Passenger + Apache module through Phusion's YUM repository.
sudo yum install -y epel-release pygpgme curl
# Add our el7 YUM repository
sudo curl --fail -sSLo /etc/yum.repos.d/passenger.repo https://oss-binaries.phusionpassenger.com/yum/definitions/el-passenger.repo
# Install Passenger + Apache module
sudo yum install -y mod_passenger  passenger-devel

# Step 2:  restart Apache
#Now that the Passenger Apache module is installed, restart Apache to ensure that Passenger is activated:
sudo systemctl restart httpd

# Step 3: check installation
#After installation, please validate the install by running sudo passenger-config validate-install. For example:
sudo passenger-config validate-install | grep "Everything looks good. :-)"

#Something breaks with SELinux, I have not had the time to find it
sudo setenforce 0

touch ~/passenger