require_relative 'routes/api'

Panda::Engine.routes.draw do

  devise_for :users, controllers: { sessions: 'user/sessions' }

  resource :wechat, only: [:show, :create]
end
