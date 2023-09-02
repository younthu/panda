RAILS_ENV=production bundle exec rails assets:precompile

docker build . -t registry.cn-shanghai.aliyuncs.com/younthu/<%=config[:app_name]%>:latest

docker login --username=younthu --password=xxxxxxx registry.cn-shanghai.aliyuncs.com

docker push registry.cn-shanghai.aliyuncs.com/younthu/<%=config[:app_name]%>:latest

ssh yoga.ilibrary.me "./restart_<%=config[:app_name]%>.sh"
