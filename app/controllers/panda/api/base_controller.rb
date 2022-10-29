class Panda::Api::BaseController < ::ApplicationController
  layout 'panda/layouts/application'
  skip_before_action :verify_authenticity_token

  if Panda.token_method == :secure_token
    include AuthenticationPlugin
  else
    include DeviseTokenAuth::Concerns::SetUserByToken
  end
  include ErrorsPlugin
  include ParamsPlugin
  include QuickPlugin

  helper :'panda/application'


  before_action :authenticate_user!

  rescue_from ActiveRecord::RecordInvalid do |e|
    render json: e.record.errors, status: :unprocessable_entity
  end
end
