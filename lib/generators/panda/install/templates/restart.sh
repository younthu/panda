docker login --username=651xxx@qq.com --password=xxxxxx1212036 registry.cn-shanghai.aliyuncs.com

docker pull registry.cn-shanghai.aliyuncs.com/younthu/<%=app_name%>:latest

docker run --rm -e RACK_ENV=production registry.cn-shanghai.aliyuncs.com/younthu/<%=app_name%>:latest bundle exec rake db:migrate

docker rm -f <%=app_name%>_sidekiq

docker run -d --restart=always --name <%=app_name%>_sidekiq registry.cn-shanghai.aliyuncs.com/younthu/<%=app_name%>:latest bundle exec sidekiq -C config/sidekiq.yml -e production

docker rm -f <%=app_name%>

docker run -d --restart=always -p 3000:3000 --name <%=app_name%> registry.cn-shanghai.aliyuncs.com/younthu/<%=app_name%>:latest bundle exec rails s -e production

docker image prune -f
docker container prune -f

docker ps

docker network connect --alias <%=app_name%> <%=app_name%>-net <%=app_name%>

docker logs -f <%=app_name%>
