#! /usr/bin/env sh
# 这个脚本用于在host里更新代码，重新部署，不带回滚功能。 这个脚本通过指定的
echo "This script runs in host."

git checkout Gemfile.lock
GIT_SSH_COMMAND='ssh -i /root/.ssh/driftbottle_deploy -o IdentitiesOnly=yes' git pull
docker exec driftbottle bundle install
docker exec driftbottle bundle exec rails db:migrate
touch tmp/restart.txt