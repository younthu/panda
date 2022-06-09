class Panda::Api::BaseController < ::ApplicationController
  layout 'panda/layouts/application'

  if Panda.token_method == :secure_token
    include AuthenticationPlugin
  else
    include DeviseTokenAuth::Concerns::SetUserByToken
  end
  include ErrorsPlugin
  include ParamsPlugin
  include QuickPlugin

  helper :'panda/application'

  skip_before_action :verify_authenticity_token if self.respond_to? :verify_authenticity_token

  before_action :authenticate_user!

  rescue_from ActiveRecord::RecordInvalid do |e|
    render json: e.record.errors, status: :unprocessable_entity
  end
end
