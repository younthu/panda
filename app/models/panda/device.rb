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
#  panda_user_id   :integer
#
# Indexes
#
#  index_panda_devices_on_panda_user_id  (panda_user_id)
#
# Foreign Keys
#
#  panda_user_id  (panda_user_id => panda_users.id)
#
module Panda
  class Device < ApplicationRecord
    belongs_to :user
  end
end
