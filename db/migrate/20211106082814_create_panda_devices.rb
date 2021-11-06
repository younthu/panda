class CreatePandaDevices < ActiveRecord::Migration[6.1]
  def change
    create_table :panda_devices do |t|
      t.references :user, null: true, foreign_key: {to_table: :panda_users}, comment: '该设备属于谁'
      t.string :token, comment: '设备token, 苹果设备责是push token'
      t.string :name, comment: 'agent名称,eg, chrome. 设备发送请求的时候会把agent信息带过来'
      t.string :full_version, comment: '设备版本'
      t.string :os_name, comment: '设备操作系统'
      t.string :os_full_version, comment: '设备操作系统详细信息'
      t.string :device_name, comment: '设备名称'
      t.string :device_type, comment: '设备类型, iOS/android'

      t.timestamps
    end
  end
end
