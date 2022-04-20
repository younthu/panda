# == Schema Information
#
# Table name: panda_order_items
#
#  id         :integer          not null, primary key
#  item_type  :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  item_id    :integer          not null
#  order_id   :integer          not null
#
# Indexes
#
#  index_panda_order_items_on_item      (item_type,item_id)
#  index_panda_order_items_on_order_id  (order_id)
#
# Foreign Keys
#
#  order_id  (order_id => panda_orders.id)
#
module Panda
  class OrderItem < ApplicationRecord
    belongs_to :order
    belongs_to :item, polymorphic: true
  end
end
