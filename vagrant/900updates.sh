#!/usr/bin/env bash

#source /usr/local/rvm/scripts/rvm


#1 Transferring latest code


#Starting from this point, unless stated otherwise, all commands that we instruct you to run should be run on the server,
# not on your local computer!
#1.2 Pull latest code from Git



#2 Prepare application

#2.2 Install app dependencies

#Your application's gem dependencies may have changed, so we should install any updated gem dependencies. Run:
bundle config build.nokogiri --use-system-libraries #Because nokogiri does not like nokogiri....
bundle install --deployment --without development test

#2.3 Compile Rails assets and run database migrations

#If your app is a Rails app, then you need to compile the latest Rails assets and run any database migrations. If your
# app is not a Rails app, please skip to the next step.

bundle exec rake assets:precompile db:migrate RAILS_ENV=production

#3 Restart application

#Passenger may still be serving an old instance of your application. Now that all application updates have been prepared,
# tell Passenger to restart your application so that the updates take effect.

passenger-config restart-app /var/www/sufia/code