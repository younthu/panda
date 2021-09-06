class AddAvatarToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :panda_users, :photos, :string
    add_column :panda_users, :avatar, :string
  end
end
