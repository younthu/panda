module Panda
  module Api
  class UsersController < BaseController

    # TODO: Fixme
    def upload_avatar
      current_user.update({avatar: params[:user][:avatar]})
      current_user.reload
      my_info
    end

    def my_info
      render json: current_user
    end
  end
  end
end
