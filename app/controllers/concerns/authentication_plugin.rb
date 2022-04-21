# frozen_string_literal: true

module AuthenticationPlugin
  extend ActiveSupport::Concern

  def authenticate_user!
    raise CustomMessageError.new(401, '认证失败') if current_user.blank?
  end

  private

  def current_user
    @current_user ||= User.where(secure_token: request_token).first
  end

  def request_token
    request.headers['Authorization'] || request.params[:secure_token]
  end
end
