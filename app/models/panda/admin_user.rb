# == Schema Information
#
# Table name: panda_admin_users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_panda_admin_users_on_email                 (email) UNIQUE
#  index_panda_admin_users_on_reset_password_token  (reset_password_token) UNIQUE
#
module Panda
  class AdminUser < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable,
           :recoverable, :rememberable, :validatable

    # 角色化, 基于rolify, https://github.com/RolifyCommunity/rolify/wiki/Configuration
    rolify  :role_cname => "Panda::AdminRole" , :role_join_table_name => "panda_admin_users_panda_admin_roles",
            before_add: :before_add_method # support before_add, after_add, before_remove, after_remove

    def before_add_method(role)
      # do something before it gets added, eg, email notification, or alert, or audit.
    end
  end
end
