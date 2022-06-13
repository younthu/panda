# == Schema Information
#
# Table name: panda_users
#
#  id                     :integer          not null, primary key
#  allow_password_change  :boolean          default(FALSE)
#  avatar                 :string
#  birthday               :date
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string
#  encrypted_password     :string           default(""), not null
#  gender                 :integer
#  mobile                 :string
#  name                   :string
#  nickname               :string
#  photos                 :string
#  provider               :string           default("email"), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  secure_token           :string
#  tokens                 :text
#  uid                    :string           default(""), not null
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_panda_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_panda_users_on_email                 (email) UNIQUE
#  index_panda_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_panda_users_on_secure_token          (secure_token) UNIQUE
#  index_panda_users_on_uid_and_provider      (uid,provider) UNIQUE
#
module Panda
  class User < ApplicationRecord
    enum gender: {female: 0, male: 1, f: 0, m: 1} # enum usage: https://naturaily.com/blog/ruby-on-rails-enum

      # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable
    include DeviseTokenAuth::Concerns::User
    alias auth_token create_new_auth_token

    has_secure_token :secure_token , length: 32 # secure_token, Token requires a minimum length of 24 characters.
    include Panda::AppendPhotos

    mount_uploader :avatar, AvatarUploader
    mount_uploaders :photos, PhotoUploader # 用户头像顶部照片
    serialize :photos, JSON # If you use SQLite, add this line. if using psql, alter photos to type of json rails g migration add_avatars_to_users photos:json

    def age
      return unless self.birthday
      Date.today.year - self.birthday.year
    end

    def as_json(options = {})
      super(options).merge({
        age: age
      })
    end
  end
end
