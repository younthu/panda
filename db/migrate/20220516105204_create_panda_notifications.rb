class CreatePandaNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :panda_notifications do |t|
      t.references :sender, polymorphic: true, null: true, comment: '通知谁发的, 默认是系统，所以可以省略'
      t.references :receiver, null: false, foreign_key: {to_table: :panda_users}, comment: '接收者, 这个通知给谁的'
      t.references :payload, polymorphic: true, null: true, comment: '消息附加的内容，比如一件商品，一张图片，另外一个消息等'
      t.string :body, comment: '通知的内容'
      t.boolean :read, default: false, comment: '通知是否已读'
      t.string :type,  default: 'notification', comment: '通知类型, 可以发给app用的，还有给用户的'

      t.timestamps
    end
  end
end
