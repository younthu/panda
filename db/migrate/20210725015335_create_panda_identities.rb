class CreatePandaIdentities < ActiveRecord::Migration[6.1]
  def change
    create_table :panda_identities do |t|
      t.references :user, null: false, foreign_key: {to_table: :panda_users}
      t.string :uid, comment: '用户UID'
      t.string :provider
      t.string :status
      t.string :token
      t.string :refresh_token
      t.string :scopes
      t.integer :expires_at

      t.timestamps
    end
    add_index :panda_identities, :uid
    add_index :panda_identities, :provider
    add_index :panda_identities, :status
    add_index :panda_identities, :token
    add_index :panda_identities, :refresh_token
  end
end
