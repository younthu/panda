class Panda::Api::BaseController < ::ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken

  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!
  include DeviseTokenAuth::Concerns::SetUserByToken

  rescue_from ActiveRecord::RecordInvalid do |e|
    render json: e.record.errors, status: :unprocessable_entity
  end
end
