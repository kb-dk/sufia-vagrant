#!/usr/bin/env bash


set -e
if [ -f ~/app-env ]; then
    exit
fi

#2.2 Install app dependencies

#Your application has various dependencies. They must be installed. Most of these dependencies are gems in your Gemfile,
# managed by Bundler. You can install them by running bundle install --deployment --without development test -j 2 in
# your app's directory:

sudo yum install -y git # Because sufia has a github dependency
cd /var/www/sufia/code
bundle config build.nokogiri --use-system-libraries #Because nokogiri does not like nokogiri....
bundle install --clean --deployment --without development test

#Your app may also depend on services, such as PostgreSQL, Redis, etc. Installing services that your app depends on is outside of this walkthrough's scope.

#Start background processes that are required
#This is the crap that is needed for the jetty to run....
sudo yum -y install java
pushd ~/
rake jetty:clean -f /var/www/sufia/code/Rakefile #Because fedora4 does not like the vagrant shared directoreis...
rake sufia:jetty:config -f /var/www/sufia/code/Rakefile
cd jetty
java -Djetty.port=8983 -Dsolr.solr.home=$HOME/jetty/solr -Xmx512m -XX:MaxPermSize=128m -jar start.jar
popd

#Start background workers
#Sufia uses a queuing system named Resque to manage long-running or slow processes. Resque relies on the redis key-value
# store, so redis must be installed and running on your system in order for background workers to pick up jobs.
#Unless redis has already been started, you will want to start it up. You can do this either by calling the redis-server
# command, or if you're on certain Linuxes, you can do this via sudo service redis-server start.
#Next you will need to spawn Resque's workers.
sudo yum -y install redis
sudo systemctl restart redis.service
sudo systemctl enable redis.service
redis-cli ping | grep PONG
QUEUE=* rake environment resque:work



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

if grep SECRET_KEY_BASE config/secrets.yml; then
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
fi

#To prevent other users on the system from reading sensitive information belonging to your app, let's tighten the
# security on the configuration directory and the database directory:
chmod 700 config db
chmod 600 config/database.yml config/secrets.yml


#2.4 Compile Rails assets and run database migrations

#Run the following command to compile assets for the Rails asset pipeline, and to run database migrations:
bundle exec rake assets:precompile db:migrate RAILS_ENV=production




touch ~/app-env