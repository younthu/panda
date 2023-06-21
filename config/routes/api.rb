# require_relative '../../app/models/panda/user.rb'

def draw_apis

  Rails.application.routes.draw do
    # free news' attachment
    # get '/free/attachment/translation/file/:id/*file_name', to: 'download_center#get_free_attachment'
    ActiveAdmin.routes(self)
    devise_for :admin_users,  ActiveAdmin::Devise.config.merge(class_name: "Panda::AdminUser")
    #
    # mount Rswag::Ui::Engine => '/api-docs'
    # mount Rswag::Api::Engine => '/api-docs'
  end

  Panda::Engine.routes.draw do
    devise_for :users, path: "users", class_name: "User", controllers: { sessions: 'user/sessions', class_name: "User" }

    namespace :api do
      scope :v1 do
        mount_devise_token_auth_for 'User', at: 'users', controllers: {
          # token_validations:  'api/users/token_validations',
          # omniauth_callbacks: 'user/omniauth_callbacks',
          sessions: 'panda/api/users/sessions',
          registrations: 'panda/api/users/registrations'
        }
        namespace :users do
          post :create
          put :change_password
          get :my_info
          put :update_my_info
          post :upload_avatar
          post :append_photo
          post :bind_ios_device_token
          post :sms_login
          post :sms
          delete :delete_account
          post :block_user
          post :unblock_user
          get :blacklist
          post :report_abuse
        end

        resources :orders do
          collection do
            post :wechat_mini_notify
            get :photographer_orders
            get :has_new_order
            put :mark_all_orders_as_read
          end

          member do
            put :confirm_order
            put :done_order
            put :reject_order
            put :cancel_order
            post :comment
          end
        end

        resources :messages
        resources :notifications
      end


      # 微信登录
      resource :login_by_code, only: %i[create] do
        post :bindWechat
      end
    end
  end if Object.const_defined? Panda.userClassName.classify

end
