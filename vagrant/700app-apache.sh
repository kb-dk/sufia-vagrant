#!/usr/bin/env bash


set -e
if [ -f ~/app-apache ]; then
    exit
fi


#3 Configuring Apache and Passenger

#Now that you are done with transferring your app's code to the server and setting up an environment for your app, it is
# time to configure Apache so that Passenger knows how to serve your app.

#3.1 Determine the Ruby command that Passenger should use

#We need to tell Passenger which Ruby command it should use to run your app, just in case there are multiple Ruby
# interpreters on your system. Please run passenger-config about ruby-command to find out which Ruby interpreter you
# are using. For example:

#passenger-config about ruby-command
#passenger-config was invoked through the following Ruby interpreter:
#  Command: /usr/local/rvm/gems/ruby-2.2.1/wrappers/ruby
#  Version: ruby 2.2.1p85 (2015-02-26 revision 49769) [x86_64-linux]
#  ...
#Please take note of the path after "Command" (in this example, /usr/local/rvm/gems/ruby-2.2.1/wrappers/ruby). You will
# need it in one of the next steps.



#3.3 Edit Apache configuration file

#We need to create an Apache configuration file and setup a virtual host entry that points to your app. This virtual
# host entry tells Apache (and Passenger) where your app is located.

sudo cp -f /vagrant/passenger-ruby-rails-demo.conf /etc/httpd/conf.d/passenger-ruby-rails-demo.conf
#Replace myapp with your app's name.

#When you are done, restart Apache:
sudo apachectl restart


#3.4 Test drive
#
#You should now be able to access your app through the server's host name! Try running this from your local computer.
# Replace yourserver.com with your server's hostname, exactly as it appears in the Apache config file's ServerName directive.

#curl http://yourserver.com/
#...your app's front page HTML...
#If you do not see your app's front page HTML, then these are the most likely causes:

#You did not correctly configure your ServerName directive. The ServerName must exactly match the host name in the URL.
# For example, if you use the command curl http://45.55.91.235/ to access your app, then the ServerName must be 45.55.91.235.
#You did not setup DNS records. Setting up DNS is outside the scope of this walkthrough. In the mean time, we recommend
# that you use your server's IP address as the server name.

touch ~/app-apache