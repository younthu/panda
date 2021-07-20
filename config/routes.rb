require_relative 'routes/api'

Panda::Engine.routes.draw do
  resource :wechat, only: [:show, :create]
end
