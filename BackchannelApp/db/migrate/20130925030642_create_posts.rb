class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :title
      t.text :content

      t.references :category
      t.references :user
      t.timestamps
    end
  end
end
