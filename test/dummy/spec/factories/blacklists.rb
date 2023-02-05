# == Schema Information
#
# Table name: blacklists
#
#  id            :bigint           not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  black_user_id :integer
#  user_id       :bigint
#
# Indexes
#
#  index_blacklists_on_user_id  (user_id)
#
FactoryBot.define do
  factory :blacklist do
    user
    black_user_id { create :user }
  end
end
