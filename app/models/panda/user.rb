module Panda
  class User < ApplicationRecord
      # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable
    include DeviseTokenAuth::Concerns::User

      alias auth_token create_new_auth_token

  end
end
