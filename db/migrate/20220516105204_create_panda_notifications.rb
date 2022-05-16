class CreatePandaNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :panda_notifications do |t|
      t.references :sender, polymorphic: true, null: true, comment: '通知谁发的, 默认是系统，所以可以省略'
      t.references :receiver, null: false, foreign_key: {to_table: :panda_users}, comment: '接收者, 这个通知给谁的'
      t.references :payload, polymorphic: true, null: false
      t.string :body, comment: '通知的内容'
      t.boolean :read, comment: '通知是否已读'
      t.string :type,  comment: '通知类型, 可以分给app用的，还有给用户的'

      t.timestamps
    end
  end
end
