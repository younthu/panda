# frozen_string_literal: true

# == Schema Information
#
# Table name: banners
#
#  id                                                :bigint           not null, primary key
#  category(广告banner类型)                          :string
#  image                                             :string
#  link(跳转链接, 可以是网页链接，也可以是app内跳转) :string
#  title(标题)                                       :string
#  created_at                                        :datetime         not null
#  updated_at                                        :datetime         not null
#
FactoryBot.define do
  factory :banner do
    title { 'MyString' }
    link { 'MyString' }
    category { 'mall' }
  end
end
