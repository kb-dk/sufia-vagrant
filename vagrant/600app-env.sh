#!/usr/bin/env bash


set -e
if [ -f ~/app-env ]; then
    exit
fi


#2 Preparing the app's environment

#2.1 Login as the app's user

#All subsequent instructions must be run under the application's user account.

#Since you are using RVM, make sure that you activate the Ruby version that you want to run your app under. For example:
source /usr/local/rvm/scripts/rvm

rvm use ruby-2.2.1


#2.2 Install app dependencies

#Your application has various dependencies. They must be installed. Most of these dependencies are gems in your Gemfile,
# managed by Bundler. You can install them by running bundle install --deployment --without development test -j 2 in
# your app's directory:

cd /var/www/passenger-ruby-rails-demo/code
bundle install --deployment --without development test

#Your app may also depend on services, such as PostgreSQL, Redis, etc. Installing services that your app depends on is outside of this walkthrough's scope.



#2.3 Configure database.yml and secrets.yml

#Since your Rails app probably needs a database, you need to edit config/database.yml. For demonstration purposes,
# we will setup your app with an SQLite database because that is the easiest.

#Open the file:

#vi config/database.yml
#Ensure that the production section looks like this:

#production:
#  adapter: sqlite3
#  database: db/production.sqlite3
#Rails also needs a unique secret key with which to encrypt its sessions. Starting from Rails 4, this secret key is
# stored in config/secrets.yml. But first, we need to generate a secret key. Run:

secret=$(bundle exec rake secret)
#...
#This command will output a secret key. Copy that value to your clipboard. Next, open config/secrets.yml:

sed -i 's/<%=\s*ENV\["SECRET_KEY_BASE"\]\s*%>/'$secret'/g' config/secrets.yml
#If the file already exists, look for this:

#production:
#  secret_key_base: <%=ENV["SECRET_KEY_BASE"]%>

#Then replace it with the following. If the file didn't already exist, simply insert the following.

#production:
#  secret_key_base: the value that you copied from 'rake secret'

#To prevent other users on the system from reading sensitive information belonging to your app, let's tighten the
# security on the configuration directory and the database directory:
chmod 700 config db
chmod 600 config/database.yml config/secrets.yml


#2.4 Compile Rails assets and run database migrations

#Run the following command to compile assets for the Rails asset pipeline, and to run database migrations:
bundle exec rake assets:precompile db:migrate RAILS_ENV=production

touch ~/app-env