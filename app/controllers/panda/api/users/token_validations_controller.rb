module Api
  module Users
    class TokenValidationsController < ::DeviseTokenAuth::TokenValidationsController
      def validate_token
        super
      end
    end
  end
end
