class AddSecureTokenToPandaUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :panda_users, :secure_token, :string, default: ''
  end
end
