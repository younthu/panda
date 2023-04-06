# == Schema Information
#
# Table name: panda_blacklists
#
#  id              :integer          not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  blocked_user_id :integer          not null
#  user_id         :integer          not null
#
# Indexes
#
#  index_panda_blacklists_on_blocked_user_id  (blocked_user_id)
#  index_panda_blacklists_on_user_id          (user_id)
#
# Foreign Keys
#
#  blocked_user_id  (blocked_user_id => panda_users.id)
#  user_id          (user_id => panda_users.id)
#
module Panda
  class Blacklist < ApplicationRecord
    belongs_to :user, class_name: ::Panda.userClassName
    belongs_to :blocked_user, class_name: ::Panda.userClassName
  end
end
