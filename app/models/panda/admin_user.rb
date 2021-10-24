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
