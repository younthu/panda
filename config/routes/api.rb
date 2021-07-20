# require_relative '../../app/models/panda/user.rb'

Rails.application.routes.draw do
  # free news' attachment
  # get '/free/attachment/translation/file/:id/*file_name', to: 'download_center#get_free_attachment'

  namespace :api do
    scope :v1 do
      mount_devise_token_auth_for 'Panda::User', at: 'users', controllers: {
          # token_validations:  'api/users/token_validations',
          # omniauth_callbacks: 'user/omniauth_callbacks',
          sessions: 'api/users/sessions'
          # registrations: 'api/users/registrations'
      }
    end

    # 微信登录
    resource :login_by_code, only: %i[create]
  end

end
