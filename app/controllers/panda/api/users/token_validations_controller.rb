class Panda::Api::Users::TokenValidationsController < ::DeviseTokenAuth::TokenValidationsController
  def validate_token
    super
  end
end

