# frozen_string_literal: true

# == Schema Information
#
# Table name: panda_users
#
#  id                                                      :bigint           not null, primary key
#  alipay_account(支付宝账号)                              :string
#  alipay_username(支付宝用户名)                           :string
#  allow_password_change                                   :boolean          default(FALSE)
#  avatar(头像)                                            :string
#  balance(余额)                                           :decimal(10, 2)   default(0.0)
#  beans(用户有多少豆豆)                                   :integer          default(0)
#  birthday(个人生日)                                      :date
#  coins                                                   :decimal(11, 2)   default(0.0)
#  confirmation_sent_at                                    :datetime
#  confirmation_token                                      :string
#  confirmed_at                                            :datetime
#  continuous_times                                        :integer          default(0)
#  deleted_at                                              :datetime
#  email                                                   :string
#  encrypted_password                                      :string           default(""), not null
#  expenditure(历史花费总额)                               :decimal(10, 2)   default(0.0)
#  gender(性别, 0, 女, 1, 男)                              :integer
#  id_card(用户身份证)                                     :string
#  invite_code(邀请码)                                     :string
#  is_agree_privacy                                        :boolean          default(FALSE)
#  last_checkin_at                                         :datetime
#  mobile(手机号)                                          :string
#  name(用户名)                                            :string
#  nickname(昵称)                                          :string
#  photos(个人顶部相册)                                    :string
#  provider                                                :string           default("email"), not null
#  redpacket(用户红包抽中的余额，能提现多少根据这个来判断) :decimal(10, 2)   default(0.0)
#  remember_created_at                                     :datetime
#  reset_password_sent_at                                  :datetime
#  reset_password_token                                    :string
#  secure_token                                            :string
#  tokens                                                  :text
#  uid                                                     :string           default(""), not null
#  unconfirmed_email                                       :string
#  created_at                                              :datetime         not null
#  updated_at                                              :datetime         not null
#  parent_id                                               :integer
#  wechat_app_open_id(微信App OpenID)                      :string
#
# Indexes
#
#  index_panda_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_panda_users_on_deleted_at            (deleted_at)
#  index_panda_users_on_email                 (email) UNIQUE
#  index_panda_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_panda_users_on_secure_token          (secure_token) UNIQUE
#  index_panda_users_on_uid_and_provider      (uid,provider) UNIQUE
#
FactoryBot.define do
  factory :user, class: 'User' do
    email { Faker::Internet.email }
    password { '123456' }
    nick_name { Faker::Name.unique.name }
    mobile { Faker::PhoneNumber.cell_phone }

    factory :child, class: 'Panda::User' do
      parent { create(:user) }
    end
  end
end
