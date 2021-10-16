# require_relative '../../app/models/panda/user.rb'

Rails.application.routes.draw do
  # free news' attachment
  # get '/free/attachment/translation/file/:id/*file_name', to: 'download_center#get_free_attachment'
  ActiveAdmin.routes(self)
  devise_for :admin_users,  ActiveAdmin::Devise.config.merge(class_name: "Panda::AdminUser")

end

Panda::Engine.routes.draw do
  devise_for :users, controllers: { sessions: 'user/sessions', class_name: "Panda::User" }

  namespace :api do
    scope :v1 do
      mount_devise_token_auth_for 'Panda::User', at: 'users', controllers: {
        # token_validations:  'api/users/token_validations',
        # omniauth_callbacks: 'user/omniauth_callbacks',
        sessions: 'panda/api/users/sessions'
        # registrations: 'api/users/registrations'
      }
      namespace :users do
        put :change_password
        get :my_info
        put :update_my_info
        post :upload_avatar
        post :append_photo
      end
    end


    # 微信登录
    resource :login_by_code, only: %i[create] do
      post :bindWechat
    end
  end
end
