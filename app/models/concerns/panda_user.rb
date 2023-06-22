module PandaUser
  extend ActiveSupport::Concern

  included do
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
      self.password = Utils::Random.digital_code(12) if password.blank?
      self.uid = mobile if uid.blank?
      # self.invite_code = Utils::Random.digital_code(8) if invite_code.blank?
      self.provider = 'mobile'
      # self.nick_name = mobile if nick_name.blank?
    end

    def age
      return unless self.birthday
      Date.today.year - self.birthday.year
    end

    # 该账号是否被禁用了。如果要查被禁用的理由，可以查disabled_for.
    def disabled?
      disabled_at && DateTime.now < disabled_to
    end

    # 禁用账号,
    # disable_for, 禁用账号的理由
    # disable_to, 禁用到什么时候, 默认到1000年以后
    def disable(disable_for="disabled by system", disable_to= 1000.years.after)
      update! disabled_for: disable_for, disabled_to: disable_to
    end

    def as_json(options = {})
      super(options).merge({
                             age: age
                           })
    end
  end
end