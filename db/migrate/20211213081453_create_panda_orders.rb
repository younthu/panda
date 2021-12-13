class CreatePandaOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :panda_orders do |t|
      t.string :comment,  comment: "备注"
      t.string :business_type, comment: "订单类型，用来区分不同的业务类型。比如会员，优惠券，商品，充值等，可以为空"
      t.string :status,   comment: '订单状态, created: 待确认, confirmed: 待支付, paying: 已支付，待确认, paid: 已支付, cancelled: 订单已取消, refunding: 退货中, refunded: 已退货'
      t.references :owner, polymorphic: true, null: true, comment: "用户(多态), 这是谁的订单"
      t.string :title,    comment: '订单标题, 在订单页面要显示的'
      t.string :code,     comment: '订单码, 腾讯那边需要一个唯一的码做支付用'
      t.integer :price_in_cent,   comment: '价格，以分为单位'

      t.timestamps
    end
  end
end
