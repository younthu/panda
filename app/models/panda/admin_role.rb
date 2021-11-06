# == Schema Information
#
# Table name: panda_admin_roles
#
#  id            :integer          not null, primary key
#  name          :string
#  resource_type :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  resource_id   :integer
#
# Indexes
#
#  admin_role_name_resource_type_and_id_index  (name,resource_type,resource_id)
#  index_panda_admin_roles_on_name             (name)
#  index_panda_admin_roles_on_resource         (resource_type,resource_id)
#
module Panda
  class AdminRole < ApplicationRecord
    has_and_belongs_to_many :admin_users, :join_table => :panda_admin_users_panda_admin_roles

    belongs_to :resource,
               :polymorphic => true,
               :optional => true


    validates :resource_type,
              :inclusion => { :in => Rolify.resource_types },
              :allow_nil => true

    scopify
  end
end
