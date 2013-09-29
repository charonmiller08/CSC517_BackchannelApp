class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
    t.string :title
    t.text :content

    t.references :post
    t.references :user
    t.timestamps
    end
  end
end
