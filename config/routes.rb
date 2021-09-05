require_relative 'routes/api'

Panda::Engine.routes.draw do

  # devise_for :admin_users, class_name: "Panda::AdminUser"
  # devise_for :users, controllers: { sessions: 'user/sessions' }

  resource :wechat, only: [:show, :create]
end
