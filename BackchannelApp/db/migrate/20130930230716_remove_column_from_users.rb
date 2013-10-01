class RemoveColumnFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :vote
  end

  def down
    add_column :users, :vote, :string
  end
end
