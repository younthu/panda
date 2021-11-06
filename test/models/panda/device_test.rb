# == Schema Information
#
# Table name: panda_devices
#
#  id              :integer          not null, primary key
#  device_name     :string
#  device_type     :string
#  full_version    :string
#  name            :string
#  os_full_version :string
#  os_name         :string
#  token           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :integer
#
# Indexes
#
#  index_panda_devices_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => panda_users.id)
#
require "test_helper"

module Panda
  class DeviceTest < ActiveSupport::TestCase
    # test "the truth" do
    #   assert true
    # end
  end
end
