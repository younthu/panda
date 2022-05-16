class CreatePandaMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :panda_messages do |t|
      t.references :sender, polymorphic: true, null: false, comment: '谁发的消息，可以是一个用户，也可以是一个分身,也可以是系统'
      t.references :receiver, polymorphic: true, null: false, comment: '发送给谁的, 可以是个人，也可以是群聊'
      t.references :payload, polymorphic: true, null: true, comment: '消息附加的内容，比如一件商品，一张图片，另外一个消息等'
      t.string :body, comment: '消息内容'
      t.boolean :read, default: false, comment: '消息是否已读'
      t.string :session_id, comment: '会话id'
      t.string :type, default: 'message',  comment: '消息类型, 可以是通知，也可以是用户消息'

      t.timestamps
    end
  end
end
