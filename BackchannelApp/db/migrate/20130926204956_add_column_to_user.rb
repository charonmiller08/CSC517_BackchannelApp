class AddColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :role, :string
    remove_column :users, :user_role_id
  end
end
