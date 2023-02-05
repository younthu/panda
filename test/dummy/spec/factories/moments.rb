# frozen_string_literal: true

# == Schema Information
#
# Table name: moments
#
#  id                      :bigint           not null, primary key
#  content(朋友圈文字)     :text
#  images                  :string           is an Array
#  moment_comments_count   :integer          default(0)
#  status                  :string           default("init")
#  video                   :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  user_id(谁发的朋友圈)   :bigint
#
# Indexes
#
#  index_moments_on_user_id  (user_id)
#
FactoryBot.define do
  factory :moment do
    content { 'MyText' }
    user
  end
end
