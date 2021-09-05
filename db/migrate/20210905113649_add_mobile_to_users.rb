class AddMobileToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :panda_users, :mobile, :string
  end
end
