class CreatePandaDevices < ActiveRecord::Migration[6.1]
  def change
    create_table :panda_devices do |t|
      t.references :panda_user, null: true, foreign_key: true
      t.string :token
      t.string :name
      t.string :full_version
      t.string :os_name
      t.string :os_full_version
      t.string :device_name
      t.string :device_type

      t.timestamps
    end
  end
end
