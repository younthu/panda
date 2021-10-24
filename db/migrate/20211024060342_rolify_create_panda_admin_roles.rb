class RolifyCreatePandaAdminRoles < ActiveRecord::Migration[6.1]
  def change
    create_table(:panda_admin_roles) do |t|
      t.string :name
      t.references :resource, :polymorphic => true

      t.timestamps
    end

    create_table(:panda_admin_users_panda_admin_roles, :id => false) do |t|
      t.references :admin_user
      t.references :admin_role
    end

    add_index(:panda_admin_roles, :name)
    add_index(:panda_admin_roles, [ :name, :resource_type, :resource_id ], name: 'admin_role_name_resource_type_and_id_index')
    add_index(:panda_admin_users_panda_admin_roles, [ :admin_user_id, :admin_role_id ], name: 'admin_user_admin_id_role_id_index')
  end
end
