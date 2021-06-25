class CreatePandaProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :panda_profiles do |t|
      t.string :store
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
