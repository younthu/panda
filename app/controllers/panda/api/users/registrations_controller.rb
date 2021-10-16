# frozen_string_literal: true

module Panda
  module Api
    module Users
      # api register with email
      class RegistrationsController < ::DeviseTokenAuth::RegistrationsController
        skip_before_action :verify_authenticity_token

        before_action :configure_sign_up_params

        def cancel
          head 403
        end

        def create
          identity = Identity.find_by(uid: params[:email].try(:strip).try(:downcase), provider: :email)
          if identity && identity.status == 'linkedin'
            render(json: { error: I18n.t('user.sign_up.already_exists_linkedin_login_account') }, status: 403)
            return
          elsif identity && identity.status == 'wechat'
            render(json: { error: I18n.t('user.sign_up.already_exists_wechat_login_account') }, status: 403)
            return
          end
          super(&:confirm)
        end

        def new
          head 403
        end

        def edit
          head 403
        end

        def update
          head 403
        end

        def destroy
          head 403
        end

        private

        def configure_sign_up_params
          devise_parameter_sanitizer.permit(:sign_up, keys: [profile_attributes: %i[name company_name job_title]])
        end
      end
    end
  end
end
