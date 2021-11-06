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
require "test_helper"

module Panda
  class AdminRoleTest < ActiveSupport::TestCase
    # test "the truth" do
    #   assert true
    # end
  end
end
