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
module Panda
  class Profile < ApplicationRecord
    belongs_to :user
  end
end
