
module Panda
  class User < ApplicationRecord
      # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable
    include DeviseTokenAuth::Concerns::User
      alias auth_token create_new_auth_token

      include Panda::AppendPhotos

      mount_uploader :avatar, AvatarUploader
      mount_uploaders :photos, PhotoUploader # 用户头像顶部照片
      serialize :photos, JSON # If you use SQLite, add this line. if using psql, alter photos to type of json rails g migration add_avatars_to_users photos:json

  end
end
