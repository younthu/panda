class CreatePandaBlacklists < ActiveRecord::Migration[7.0]
  def change
    create_table :panda_blacklists do |t|
      t.references :user, null: false, foreign_key: {to_table: "panda_users"}, comment: "谁的黑名单"
      t.references :blocked_user, null: false, foreign_key: {to_table: "panda_users"}, comment: "被屏蔽的人"

      t.timestamps
    end
  end
end
