class CreatePandaPayments < ActiveRecord::Migration[6.1]
  def change
    create_table :panda_payments do |t|
      t.references :target, polymorphic: true, null: true, comment: '购买的服务或者商品, 比如会员卡，优惠券，一张订单，可以为空。'
      t.references :payment_method, polymorphic: true, null: false, comment: '支付方式, 这个是结算策略，不是支付渠道。 这个应该被废弃，把功能移动到strategy表格里面去.'
      t.string :comment, comment: "注释，备用"
      t.references :payee, polymorphic: true, null: true, comment: "结算给谁了, 收钱的对象"
      t.references :payer, polymorphic: true, null: true, comment: "支付者，或者成本中心, 或者支付账户."
      t.integer :amount_in_cent, comment: "结算总额是多少, 单位为分"
      t.integer :fee_in_cent, comment: "平台抽拥多少, 单位为分"
      t.integer :actual_pay_in_cent, comment: "实际支付多少, actual_pay = amount - fee, 单位为分"
      t.string :channel, comment: "支付方式/渠道, 微信自动支付, 人工支付, wechat: 微信, alipay: 支付宝, cash: 现金支付, offline: 线下支付, other: 其它. 所有的支付方式都需要额外的表记录具体的支付信息"
      t.string :status, comment: '支付状态，success: 成功， failed: 失败, refunding: 正在取消, refunded: 已退款'

      t.timestamps
    end
  end
end
