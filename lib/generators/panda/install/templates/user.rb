class User < ApplicationRecord
  self.table_name = "panda_users"
  enum gender: {female: 0, male: 1, f: 0, m: 1} # enum usage: https://naturaily.com/blog/ruby-on-rails-enum

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User
  alias auth_token create_new_auth_token

  has_secure_token :secure_token , length: 32 # secure_token, Token requires a minimum length of 24 characters.
  include Panda::AppendPhotos

  mount_uploader :avatar, Panda::AvatarUploader
  mount_uploaders :photos, Panda::PhotoUploader # 用户头像顶部照片
  serialize :photos, JSON # If you use SQLite, add this line. if using psql, alter photos to type of json rails g migration add_avatars_to_users photos:json

  before_validation do
    self.email = "#{mobile}@panda.com" if email.blank?
    self.uid = mobile if uid.blank?
    self.provider = 'mobile' if provider.blank?
    self.nickname = mobile if nickname.blank?
  end

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
