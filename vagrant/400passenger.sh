#!/usr/bin/env bash



set -e
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

sudo passenger-memory-stats
#Version: 5.0.8
#Date   : 2015-05-28 08:46:20 +0200
#
#---------- Apache processes ----------
#PID    PPID   VMSize    Private  Name
#--------------------------------------
#3918   1      190.1 MB  0.1 MB   /usr/sbin/apache2
#...
#
#----- Passenger processes ------
#PID    VMSize    Private   Name
#--------------------------------
#12517  83.2 MB   0.6 MB    Passenger watchdog
#12520  266.0 MB  3.4 MB    Passenger core
#12531  149.5 MB  1.4 MB    Passenger ust-router

#Step 4: update regularly
#Apache updates, Passenger updates and system updates are delivered through the APT package manager regularly. You
# should run the following command regularly to keep them up to date:
#sudo apt-get update
#sudo apt-get upgrade
#You do not need to restart Apache or Passenger after an update, and you also do not need to modify any configuration
# files after an update. That is all taken care of automatically for you by APT.


#Something breaks with SELinux, I have not had the time to find it
sudo setenforce 0

touch ~/passenger