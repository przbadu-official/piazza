#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
RAILS_ENV=production bundle exec rake assets:precompile
RAILS_ENV=production bundle exec rake assets:clean
RAILS_ENV=production bundle exec rake db:migrate