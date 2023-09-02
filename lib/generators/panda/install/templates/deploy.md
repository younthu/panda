# 部署方式

## 阿里云镜像部署方式(deploy.sh)

本地编译好docker image, 推送到阿里云，然后通过ssh调用host里面的restart.sh拉取最新image进行部署更新.

本方式不需要把代码部署到远程，省去ssh deploy key的麻烦.

1. (只做一次) 先把restart.sh拷贝到云服务器host的当前用户工作目录下. `scp ./restart.sh host:~/restart_new_app.sh`
2. 然后`./deploy.sh`进行部署. 它会运行host上的`restart_new_app.sh`拉取最新的image进行重新部署.



## docker host远程编译部署
这种方式也是docker部署，需要提前把代码拉到远程服务器上去。

每次代码更新以后本地执行`ssh host:~/ssh_deploy.sh`进行部署更新.

这种方式比较麻烦。好处就是不需要公共的docker image server，不需要登录阿里云.
