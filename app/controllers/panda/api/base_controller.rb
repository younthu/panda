class Panda::Api::BaseController < ::ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken

  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!
  include DeviseTokenAuth::Concerns::SetUserByToken
end
