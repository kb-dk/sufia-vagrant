#!/usr/bin/env bash

set -e
if [ -f ~/ruby ]; then
    exit
fi

#On systems where sudo is configured with secure_path, the shell environment needs to be modified to set
# rvmsudo_secure_path=1. secure_path is set on most Linux systems, but not on OS X. The following command
# tries to autodetect whether it is necessary to install rvmsudo_secure_path=1, and only installs
# the environment variable if it is the code.
if sudo grep -q secure_path /etc/sudoers; then sudo sh -c "echo export rvmsudo_secure_path=1 >> /etc/profile.d/rvm_secure_path.sh" && echo "Environment variable installed"; fi
#When you are done with all this, relogin to your server to activate RVM. This is important: if you don't relogin, RVM doesn't work.

# To install the latest version of Ruby, run:
rvmsudo rvm install ruby
source /usr/local/rvm/scripts/rvm
rvm --default use ruby

# Bundler is a popular tool for managing application gem dependencies. We will use Bundler in this walkthrough, so let us install it:
rvmsudo gem install bundler --no-rdoc --no-ri

#One thing you should be aware of when using RVM, is that you should use rvmsudo instead of sudo when executing
# Ruby-related commands. This is because RVM works by manipulating environment variables. However, sudo nukes all
# environment variables for security reasons, which interferes with RVM.


touch ~/ruby