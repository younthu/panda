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
#  deleted_at             :datetime
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
#  index_panda_users_on_deleted_at            (deleted_at)
#  index_panda_users_on_email                 (email) UNIQUE
#  index_panda_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_panda_users_on_secure_token          (secure_token) UNIQUE
#  index_panda_users_on_uid_and_provider      (uid,provider) UNIQUE
#
require "test_helper"

module Panda
  class UserTest < ActiveSupport::TestCase
    setup do

    end
    test "required fields for user" do
      u1 = panda_users(:one)
      assert u1.present?
    end
  end
end
