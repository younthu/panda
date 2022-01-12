# == Schema Information
#
# Table name: panda_profiles
#
#  id         :integer          not null, primary key
#  store      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_panda_profiles_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => panda_users.id)
#
require "test_helper"

module Panda
  class ProfileTest < ActiveSupport::TestCase
    # test "the truth" do
    #   assert true
    # end
  end
end
