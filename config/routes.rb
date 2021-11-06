require_relative 'routes/api'

# engine在hot reload的时候会清理routes, 每次改动代码以后会抛no match routes错误，得重启服务器才行。(应该是routes/api里面的内容没有被正确重新加载)
# 解决办法就是把routes.draw的逻辑移动到一个方法里面，显式call一下. 原理未知.
# 一个可能的原因是require_relative不会加载已经加载过且未更改的文件，所以每次hotreload的时候engine的routes会被清楚
# 但是, require_relative 'routes/api'不会被
#
# Moreover, Kernel#require loads files once, but development is much more smooth if code gets refreshed when it changes without restarting the server.
# It would be nice to be able to use Kernel#load in development, and Kernel#require in production.
# https://guides.rubyonrails.org/v5.1/autoloading_and_reloading_constants.html
draw_apis


Panda::Engine.routes.draw do

  # devise_for :admin_users, class_name: "Panda::AdminUser"
  # devise_for :users, controllers: { sessions: 'user/sessions' }

  resource :wechat, only: [:show, :create]
end

