class DeviseTokenAuthCreatePandaUsers < ActiveRecord::Migration[6.1]
  def change

    create_table(:panda_users) do |t|
      ## Required
      t.string :provider, :null => false, :default => "email"
      t.string :uid, :null => false, :default => ""

      ## Database authenticatable
      t.string :encrypted_password, :null => false, :default => ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.boolean  :allow_password_change, :default => false

      ## Rememberable
      t.datetime :remember_created_at

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, :default => 0, :null => false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at

      t.string :email

      ## User Info
      t.string  :name,       comment: '用户名'
      t.string  :nickname,   comment: '昵称'
      t.string  :avatar,     comment: '头像'
      t.string  :photos,     comment: '个人顶部相册'
      t.date    :birthday,   comment: '个人生日'
      t.integer :gender,     comment: '性别, 0, 女, 1, 男'
      t.string  :mobile,     comment: '手机号'

      ## Tokens
      t.text :tokens

      # secure token
      t.string :secure_token

      # paranoid
      t.datetime :deleted_at, comment: '软删除'

      t.timestamps
    end

    add_index :panda_users, :email,                unique: true
    add_index :panda_users, [:uid, :provider],     unique: true
    add_index :panda_users, :reset_password_token, unique: true
    add_index :panda_users, :confirmation_token,   unique: true
    add_index :panda_users, :secure_token, unique: true
    add_index :panda_users, :deleted_at
    # add_index :users, :unlock_token,         unique: true
  end
end
