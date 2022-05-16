class CreatePandaOrderItems < ActiveRecord::Migration[6.1]
  def change
    create_table :panda_order_items do |t|
      t.references :order, null: false, foreign_key: {to_table: :panda_orders}, comment: '订单'
      t.references :item, polymorphic: true, null: false, comment: '订单绑定的商品，一个订单可以绑定多项商品'

      t.timestamps
    end
  end
end
