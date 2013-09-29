class AddColumnToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :tag, :string
    add_column :replies, :tag, :string
  end
end
