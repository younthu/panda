#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /app/tmp/pids/server.pid

# Then exec the container's main process (what's set as CMD in the Dockerfile).
#bundle exec rails s -e production

#if [ "$SERVICE_TYPE" == 'panda' ]; then
  echo "****************************************start panda puma*****************************************"
  echo "mkdir -p tmp/pids; bundle exec puma -C test/dummy/config/puma.rb"
  mkdir -p tmp/pids;
  bundle install;
  bundle exec rails assets:precompile;
# bundle exec puma -C test/dummy/config/puma.rb; # docker template里面puma路径应该为config/puma.rb
 bundle exec rails s;
#elif [ "$SERVICE_TYPE" == 'sidekiq' ]; then
#  echo "****************************************start crashreport sidekiq*************************************"
#  bundle exec sidekiq;
#fi

exec "$@"
