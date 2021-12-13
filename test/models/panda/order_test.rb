# == Schema Information
#
# Table name: panda_orders
#
#  id            :integer          not null, primary key
#  business_type :string
#  code          :string
#  comment       :string
#  owner_type    :string
#  price_in_cent :integer
#  status        :string
#  title         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  owner_id      :integer
#
# Indexes
#
#  index_panda_orders_on_owner  (owner_type,owner_id)
#
require "test_helper"

module Panda
  class OrderTest < ActiveSupport::TestCase
    # test "the truth" do
    #   assert true
    # end
  end
end
