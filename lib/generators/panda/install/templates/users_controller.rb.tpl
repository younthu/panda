class Api::UsersController < Panda::Api::BaseController
    skip_before_action :authenticate_user!, only: [:create]

    def hello
        render json: "hello"
    end
end