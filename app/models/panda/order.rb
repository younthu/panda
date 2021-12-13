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
module Panda
  class Order < ApplicationRecord

    include AASM

    belongs_to :owner, polymorphic: true
    has_many :order_items

    before_create do
      code = ''

      loop do
        # 订单量非常大的时候可能会有问题，不过那时候rails应该早撑不住了。
        # TODO: 确认code的长度，提供更健壮的code生成算法.
        code = Time.zone.now.strftime('%Y%m%d') + rand(1000..9999).to_s

        break if Order.where(code: code).first.blank?
      end

      self.code = code
      # self.price = package.price
    end

    def price
      price_in_cent / 100.0 # 如果写100，1/100 => 0, 实际应该等于0.01
    end

    # 订单状态, created: 待确认, confirmed: 待支付, paying: 已支付，待确认, paid: 已支付, cancelled: 订单已取消, refunding: 退货中,
    # refunded: 已退货, refund_rejected: 退货已拒绝, commented: 已评论
    aasm column: :status do
      state :created, initial: true
      state :paying, :cancelled, :confirmed, :rejected, :paid, :refunding, :refunded

      event :pay do
        transitions from: :created, to: :paid
      end

      event :cancel do
        transitions from: [:created, :paid], to: :cancelled
      end

      event :confirm do
        transitions from: :created, to: :confirmed
      end

      event :reject_order do
        transitions from: [:paid, :paying, :created, :confirmed], to: :rejected
      end

      event :comment_order do
        transitions from: [:photo_delivered, :commented], to: :commented
      end
    end
  end
end
