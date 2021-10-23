# frozen_string_literal: true
module Panda
  module Api
    module Users
      class SessionsController < ::DeviseTokenAuth::SessionsController
        skip_before_action :verify_authenticity_token

        include DeviseTokenAuth::Concerns::SetUserByToken
        # include Devise::Controllers::Rememberable
        # before_action :configure_sign_in_params, only: [:create]
        # layout "jquery_mobile"

        # GET /resource/sign_in
        def new
          super
          # render "login"
        end

        # POST /resource/sign_in
        def create
          # super # 默认的super没法在scope User下工作，只在AdminUser下工作，所以User下手动sign_in, 手动remember_me
          mobile = params[:user][:mobile]
          password = params[:user][:password]
          # user = User.find_by mobile: mobile
          user = User.where(mobile: mobile).last # 修复bug: 一个手机号被注册多个用户的情况下，以最新的账号为准。
          if user and user.valid_password?(password)
            sign_in :user, user
            set_user_by_token

            session[:current_user_id] = current_user&.id

            render json: user, methods: :auth_token and return
          end
          render json: "用户名密码不对!", status: 401
        end

        # DELETE /resource/sign_out
        # def destroy
        #   super
        # end

        # protected

        # If you have extra params to permit, append them to the sanitizer.
        # def configure_sign_in_params
        #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
        # end
      end
    end
  end
end
