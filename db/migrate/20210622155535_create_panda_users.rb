class CreatePandaUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :panda_users do |t|
      t.string :name
      t.string :nick_name
      t.string :avatar
      t.string :gender
      t.date :birth

      t.timestamps
    end
  end
end
